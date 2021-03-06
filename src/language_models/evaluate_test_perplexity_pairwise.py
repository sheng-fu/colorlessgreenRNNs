# Copyright (c) 2018-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

import math
import argparse
from utils import batchify, get_batch, repackage_hidden, test_get_batch

import torch
import torch.nn as nn
import numpy as np

from dictionary_corpus import Dictionary, Corpus, tokenize, Corpus_Sent, sent_tokenize_with_unks

parser = argparse.ArgumentParser(description='Evaluate perplexity of the dataset, ignoring the <unk> words')
parser.add_argument('--data', type=str, default='./data/penn',
                    help='location of the data corpus')
parser.add_argument('--test', type=str, default=None,
                    help='Indicate your test file if different from data/test.txt')
parser.add_argument('--checkpoint', type=str,  default='model.pt',
                    help='path to save the final model')
parser.add_argument('--cuda', action='store_true',
                    help='use CUDA')
parser.add_argument('--bptt', type=int, default=35,
                    help='sequence length')
parser.add_argument('--eval_path', type=str, default='eval_results.txt',
                    help='name of the output prob results')
args = parser.parse_args()

def get_log_prob(o):
    ## o should be a vector scoring possible classes
    logprobs = nn.functional.log_softmax(o,dim=0)
    return logprobs

def evaluate(data_source):
    model.eval()
    total_loss = 0
    total_len = 0

    ntokens = len(dictionary)

    hidden = model.init_hidden(eval_batch_size)
    unk_idx = dictionary.word2idx["<unk>"]

    output_file = open(args.eval_path,'a', encoding='utf8') 
    output_file.write('prob\n')

    if args.cuda:
        out_type = torch.cuda.LongTensor()
    else:
        out_type = torch.LongTensor()

    with torch.no_grad():
        for i in range(len(data_source)):
            sent_ids = data_source[i]

            data, targets = test_get_batch(sent_ids)
            output, hidden = model(data, hidden)

            output_flat = output.view(-1, ntokens)

            subset = targets != unk_idx
            targets = targets[subset]

            output_flat = output_flat[torch.arange(0, output_flat.size(0), out=out_type)[subset]]

            total_len += targets.size(0)
            curr_loss = nn.CrossEntropyLoss()(output_flat, targets).item()
            #curr_loss_comb = np.sum([math.expcurr_loss])
            #curr_log_prob = np.sum([get_log_prob(output_flat)[i][targets[i]].item() for i in range(len(targets))])
            #output_file.write(str(math.exp(curr_loss)))+'\n')
            total_loss += targets.size(0) * curr_loss
            hidden = repackage_hidden(hidden)

    return total_loss / total_len

if torch.cuda.is_available():
    if not args.cuda:
        print("WARNING: You have a CUDA device, so you should probably run with --cuda")



eval_batch_size = 1

if args.test:
    dictionary = Dictionary(args.data)

    test = sent_tokenize_with_unks(dictionary, args.test)
    print("Size, OOV", test.size(0), sum(test == dictionary.word2idx["<unk>"]))
    test_data = batchify(test, eval_batch_size, args.cuda)
    ntokens = len(dictionary)

else:
    corpus = Corpus_Sent(args.data)
    print("Size, OOV", corpus.test.size(0), sum(corpus.test == corpus.dictionary.word2idx["<unk>"]))
    test_data = batchify(corpus.test, eval_batch_size, args.cuda)
    dictionary = corpus.dictionary


# Load the best saved model.
with open(args.checkpoint, 'rb') as f:
    print("Loading the model")
    if args.cuda:
        model = torch.load(f)
    else:
        # to convert model trained on cuda to cpu model
        model = torch.load(f, map_location=lambda storage, loc: storage)

print("Evaluation on non-unk tokens")
# Run on test data.
test_loss = evaluate(test_data)
print('=' * 89)
print('Test loss {:5.2f} | test ppl {:8.2f}'.format(
    test_loss, math.exp(test_loss)))
print('=' * 89)
