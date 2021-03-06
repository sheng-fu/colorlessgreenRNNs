# Copyright (c) 2018-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

import argparse

import torch
import torch.nn as nn
import torch.nn.functional as F

import dictionary_corpus
from utils import repackage_hidden, batchify, get_batch
import numpy as np
import math

parser = argparse.ArgumentParser(description='Mask-based evaluation: extracts softmax vectors for specified words')

parser.add_argument('--data', type=str,
                    help='location of the data corpus for LM training')
parser.add_argument('--checkpoint', type=str,
                    help='model checkpoint to use')
parser.add_argument('--seed', type=int, default=1111,
                    help='random seed')
parser.add_argument('--cuda', action='store_true',
                    help='use CUDA')

parser.add_argument('--outfile', type=str, help='path to output file')
parser.add_argument('--path', type=str, help='path to test file (text) gold file (indices of words to evaluate)')
parser.add_argument('--suffix', type=str, help='suffix for generated output files which will be saved as path.output_suffix')
args = parser.parse_args()


def parse_pairwise(filepath):
    infile = open(filepath, 'r')
    outfile = open(filepath[:-4]+ '_parsed_by_token.tab', 'w')
    infile = [x for x in infile.read().split('\n') if x != '']
    for i in range(len(infile)):
        if i % 2 == 0:
            outfile.write(infile[i] + '\t' + infile[i+1] + '\n')

    return None
        


def evaluate(data_source):
    # Turn on evaluation mode which disables dropout.
    model.eval()
    total_loss = 0

    hidden = model.init_hidden(eval_batch_size)

    outfile = open(args.outfile, "w")
    with torch.no_grad():
        for i in range(len(data_source[0])):
            # keep continuous hidden state across all sentences in the input file
            data = data_source[1][i][:-1].tolist()
            data = torch.LongTensor([[x] for x in data])
            targets = data_source[1][i][1:].view(-1)

            if args.cuda:
                data = data.cuda()
                targets = targets.cuda()

            #_, targets_mask = get_batch(mask, i, seq_len)
            output, _ = model(data, hidden)
            output_flat = output.view(-1, vocab_size)


            total_loss += len(data) * nn.CrossEntropyLoss()(output_flat, targets)

            print(data_source[0][i])

            #calculate token-specific entropy
            m = nn.LogSoftmax()
            output_logit = m(output_flat)
            entropy_tensor = -(torch.exp(output_logit) * output_logit).sum(dim=-1)

            #calculate token-specific logit
            logit_tensor = nn.CrossEntropyLoss(reduction='none')(output_flat, targets)

            #output 
            outfile.write(data_source[0][i] + '\t' + str(entropy_tensor.tolist()) + '\t' + str(logit_tensor.tolist()) + '\n')

            hidden = repackage_hidden(hidden)

    return total_loss.item() / (len(data_source) - 1)


def output_candidates_probs(output_flat, targets):
    log_probs = F.log_softmax(output_flat, dim=1)

    log_probs_np = log_probs.cpu().numpy()
    #subset = mask.cpu().numpy().astype(bool)

    for scores, correct_label in zip(log_probs_np, targets.cpu().numpy()):
        #print(idx2word[correct_label], scores[correct_label])
        f_output.write("\t".join(str(s) for s in scores) + "\n")


def create_target_mask(test_file, gold_file, index_col):
    sents = open(test_file, "r").readlines()
    golds = open(gold_file, "r").readlines()
    #TODO optimize by initializaing np.array of needed size and doing indexing
    targets = []
    for sent, gold in zip(sents, golds):
        # constr_id, sent_id, word_id, pos, morph
        target_idx = int(gold.split()[index_col])
        len_s = len(sent.split(" "))
        t_s = [0] * len_s
        t_s[target_idx] = 1
        #print(sent.split(" ")[target_idx])
        targets.extend(t_s)
    return np.array(targets)

# Set the random seed manually for reproducibility.
torch.manual_seed(args.seed)
if torch.cuda.is_available():
    if not args.cuda:
        print("WARNING: You have a CUDA device, so you should probably run with --cuda")
    else:
        torch.cuda.manual_seed(args.seed)

with open(args.checkpoint, 'rb') as f:
    print("Loading the model")
    if args.cuda:
        model = torch.load(f)
    else:
        # to convert model trained on cuda to cpu model
        model = torch.load(f, map_location = lambda storage, loc: storage)
model.eval()

if args.cuda:
    model.cuda()
else:
    model.cpu()

eval_batch_size = 1
seq_len = 20

dictionary = dictionary_corpus.Dictionary(args.data)
vocab_size = len(dictionary)
#print("Vocab size", vocab_size)
print("Computing probabilities for target words")

# assuming the mask file contains one number per line indicating the index of the target word
index_col = 0

#mask = create_target_mask(args.path + ".text", args.path + ".eval", index_col)
#mask_data = batchify(torch.LongTensor(mask), eval_batch_size, args.cuda)
test_data = dictionary_corpus.sent_tokenize_with_unks(dictionary, args.path + ".txt")
#print(test_data[0][0])
#print(test_data[1][0])

f_output = open(args.outfile[:-4] + ".output_by_token" + args.suffix, 'w')
evaluate(test_data)
parse_pairwise(args.outfile)
print("Probabilities saved to", args.path + ".output_by_token" + args.suffix)
f_output.close()


