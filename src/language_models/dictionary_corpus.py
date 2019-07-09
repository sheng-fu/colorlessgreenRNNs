# Copyright (c) 2018-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

import os
import torch
from collections import defaultdict
import logging

class Dictionary(object):
    def __init__(self, path):
        self.word2idx = {}
        self.idx2word = []
        self.word2freq = defaultdict(int)

        vocab_path = os.path.join(path, 'vocab.txt')
        try:
            vocab = open(vocab_path, encoding="utf8").read()
            self.word2idx = {w: i for i, w in enumerate(vocab.split())}
            self.idx2word = [w for w in vocab.split()]
            self.vocab_file_exists = True
        except FileNotFoundError:
            logging.info("Vocab file not found, creating new vocab file.")
            self.create_vocab(os.path.join(path, 'train.txt'))
            open(vocab_path,"w").write("\n".join([w for w in self.idx2word]))

    def add_word(self, word):
        self.word2freq[word] += 1
        if word not in self.word2idx:
            self.idx2word.append(word)
            self.word2idx[word] = len(self.idx2word) - 1
        #return self.word2idx[word]

    def __len__(self):
        return len(self.idx2word)

    def create_vocab(self, path):
        with open(path, 'r', encoding="utf8") as f:
            for line in f:
                words = line.split()
                for word in words:
                    self.add_word(word)


class Corpus(object):
    def __init__(self, path):
        self.dictionary = Dictionary(path)
        self.train = tokenize(self.dictionary, os.path.join(path, 'train.txt'))
        self.valid = tokenize(self.dictionary, os.path.join(path, 'valid.txt'))
        self.test = tokenize(self.dictionary, os.path.join(path, 'test.txt'))


class SentenceCorpus(object):
    def __init__(self, lm_path, save_to='lm_data.bin', testflag=False,
                 trainfname='train.txt',
                 validfname='valid.txt',
                 testfname='test.txt'):
        if not testflag:
            self.dictionary = Dictionary()
            self.train_lm = self.tokenize(os.path.join(lm_path, trainfname))
            self.valid_lm = self.tokenize_with_unks(os.path.join(lm_path, validfname))
            self.save_to = self.save_dict(save_to)
        else:
            self.dictionary = self.load_dict(save_to)
            self.test_lm = self.sent_tokenize_with_unks(os.path.join(lm_path,testfname))


    def save_dict(self, path):
        with open(path, 'wb') as f:
            torch.save(self.dictionary, f, pickle_module=dill)

    def load_dict(self, path):
        #assert os.path.exists(path)
        with open(path, 'rb') as f:
            fdata = torch.load(f, pickle_module=dill)
            if type(fdata) == type(()):
                # compatibility with old pytorch LM saving
                return(fdata[3])
            return(fdata)

    def tokenize_ccg(self, path):
        """Tokenizes and gets CCG tags for a text file."""
        assert os.path.exists(path)

        # Add words and tags to the dictionary
        with open(path, 'r') as f:
            tokens = 0
            FIRST = True
            for line in f:
                if line.strip() != "":
                    (word, tag) = line.strip().split("\t")
                    if FIRST:
                        self.dictionary.add_word("<eos>")
                        self.dictionary.add_tag("<EOS>")
                        tokens += 1
                        FIRST = False
                    self.dictionary.add_word(word)
                    self.dictionary.add_tag(tag)
                    tokens += 1
                    if word == '.':
                        FIRST = True
                        self.dictionary.add_word("<eos>")
                        self.dictionary.add_tag("<EOS>")
                        tokens += 1
        # Tokenize file content
        with open(path, 'r') as f:
            word_ids = torch.LongTensor(tokens)
            tag_ids = torch.LongTensor(tokens)
            token = 0
            FIRST = True
            for line in f:
                if line.strip() != "":
                    if FIRST:
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = False
                    (word, tag) = line.strip().split("\t")
                    word_ids[token] = self.dictionary.word2idx[word]
                    tag_ids[token] = self.dictionary.tag2idx[tag]
                    token += 1
                    if word == ".":
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = True
        return word_ids, tag_ids

    def tokenize_ccg_with_unks(self, path):
        """Tokenizes and gets CCG tags for a text file."""
        assert os.path.exists(path)

        # Add words and tags to the dictionary
        with open(path, 'r') as f:
            tokens = 0
            FIRST = True
            for line in f:
                if line.strip() != "":
                    (word, tag) = line.strip().split("\t")
                    if FIRST:
                        tokens += 1
                        FIRST = False
                    tokens += 1
                    if word == '.':
                        FIRST = True
                        tokens += 1
        # Tokenize file content
        with open(path, 'r') as f:
            word_ids = torch.LongTensor(tokens)
            tag_ids = torch.LongTensor(tokens)
            token = 0
            FIRST = True
            for line in f:
                if line.strip() != "":
                    if FIRST:
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = False
                    (word, tag) = line.strip().split("\t")
                    if word not in self.dictionary.word2idx:
                        word_ids[token] = self.dictionary.add_word["<unk>"]
                    else:
                        word_ids[token] = self.dictionary.word2idx[word]
                    if tag not in self.dictionary.tag2idx:
                        tag_ids[token] = self.dictionary.add_tag["<UNK>"]
                    else:
                        tag_ids[token] = self.dictionary.tag2idx[tag]
                    
                    token += 1
                    if word == ".":
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = True
        return word_ids, tag_ids

    def sent_tokenize_ccg_with_unks(self, path):
        """Tokenizes and gets CCG tags for a text file."""
        assert os.path.exists(path)
        sents = []
        # Add words and tags to the dictionary
        with open(path, 'r') as f:
            tokens = 0
            FIRST = True
            for line in f:
                if line.strip() != "":
                    (word, tag) = line.strip().split("\t")
                    if FIRST:
                        tokens += 1
                        FIRST = False
                    tokens += 1
                    if word == '.':
                        FIRST = True
                        tokens += 1
        # Tokenize file content
        with open(path, 'r') as f:
            word_ids = torch.LongTensor(tokens)
            tag_ids = torch.LongTensor(tokens)
            token = 0
            sent = []
            FIRST = True
            for line in f:
                if line.strip() != "":
                    if FIRST:
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = False
                        sent.append(("<eos>", "<EOS>"))
                    (word, tag) = line.strip().split("\t")
                    sent.append((word, tag))
                    if word not in self.dictionary.word2idx:
                        word_ids[token] = self.dictionary.add_word["<unk>"]
                    else:
                        word_ids[token] = self.dictionary.word2idx[word]
                    if tag not in self.dictionary.tag2idx:
                        tag_ids[token] = self.dictionary.add_tag["<UNK>"]
                    else:
                        tag_ids[token] = self.dictionary.tag2idx[tag]
                    
                    token += 1
                    if word == ".":
                        word_ids[token] = self.dictionary.word2idx["<eos>"]
                        tag_ids[token] = self.dictionary.tag2idx["<EOS>"]
                        token += 1
                        FIRST = True
                        sent.append(("<eos>", "<EOS>"))
                        sents.append(sent)
                        sent = []
        return sents, word_ids, tag_ids
                    
        

    def tokenize(self, path):
        """Tokenizes a text file."""
        assert os.path.exists(path)
        # Add words to the dictionary
        if path[-2:] == 'gz':
            with gzip.open(path, 'rb', encoding="utf-8") as f:
                tokens = 0
                for line in f.readlines():
                    words = ['<eos>'] + line.split()
                    tokens += len(words)
                    for word in words:
                        self.dictionary.add_word(word)

            # Tokenize file content
            with gzip.open(path, 'rb', encoding="utf-8") as f:
                ids = torch.LongTensor(tokens)
                token = 0
                for line in f.readlines():
                    words = ['<eos>'] + line.split()
                    for word in words:
                        ids[token] = self.dictionary.word2idx[word]
                        token += 1
        else:
            with open(path, 'r+', encoding="utf-8") as f:
                tokens = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    tokens += len(words)
                    for word in words:
                        self.dictionary.add_word(word)

            # Tokenize file content
            with open(path, 'r+', encoding="utf-8") as f:
                ids = torch.LongTensor(tokens)
                token = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    for word in words:
                        ids[token] = self.dictionary.word2idx[word]
                        token += 1
        return ids

    def tokenize_with_unks(self, path):
        """Tokenizes a text file, adding unks if needed."""
        assert os.path.exists(path)
        if path[-2:] == 'gz':
            # Add words to the dictionary
            with gzip.open(path, 'rb', encoding="utf-8") as f:
                tokens = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    tokens += len(words)

            # Tokenize file content
            with gzip.open(path, 'rb', encoding="utf-8") as f:
                ids = torch.LongTensor(tokens)
                token = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    for word in words:
                        if word not in self.dictionary.word2idx:
                            ids[token] = self.dictionary.add_word("<unk>")
                        else:
                            ids[token] = self.dictionary.word2idx[word]
                        token += 1
        else:
            # Add words to the dictionary
            with open(path, 'r+', encoding="utf-8") as f:
                tokens = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    tokens += len(words)

            # Tokenize file content
            with open(path, 'r+', encoding="utf-8") as f:
                ids = torch.LongTensor(tokens)
                token = 0
                for line in f:
                    words = ['<eos>'] + line.split()
                    for word in words:
                        if word not in self.dictionary.word2idx:
                            ids[token] = self.dictionary.add_word("<unk>")
                        else:
                            ids[token] = self.dictionary.word2idx[word]
                        token += 1
        return ids

    def sent_tokenize_with_unks(self, path):
        """Tokenizes a text file into sentences, adding unks if needed."""
        assert os.path.exists(path)
        all_ids = []
        sents = []
        if path [-2:] == 'gz':
            with gzip.open(path, 'rb', encoding="utf-8") as f:
                for line in f:
                    sents.append(line.strip())
                    words = ['<eos>'] + line.split()
                    tokens = len(words)

                    # tokenize file content
                    ids = torch.LongTensor(tokens)
                    token = 0
                    for word in words:
                        if word not in self.dictionary.word2idx:
                            ids[token] = self.dictionary.add_word("<unk>")
                        else:
                            ids[token] = self.dictionary.word2idx[word]
                        token += 1
                    all_ids.append(ids)
        else:
            with open(path, 'r+', encoding="utf-8") as f:
                for line in f:
                    sents.append(line.strip())
                    words = ['<eos>'] + line.split()
                    tokens = len(words)
                    
                    # tokenize file content
                    ids = torch.LongTensor(tokens)
                    token = 0
                    for word in words:
                        if word not in self.dictionary.word2idx:
                            ids[token] = self.dictionary.add_word("<unk>")
                        else:
                            ids[token] = self.dictionary.word2idx[word]
                        token += 1
                    all_ids.append(ids)                
        return (sents, all_ids)


def tokenize(dictionary, path):
    """Tokenizes a text file for training or testing to a sequence of indices format
       We assume that training and test data has <eos> symbols """
    assert os.path.exists(path)
    with open(path, 'r', encoding="utf8") as f:
        ntokens = 0
        for line in f:
            words = line.split()
            ntokens += len(words)

    # Tokenize file content
    with open(path, 'r', encoding="utf8") as f:
        ids = torch.LongTensor(ntokens)
        token = 0
        for line in f:
            words = line.split()
            for word in words:
                if word in dictionary.word2idx:
                    ids[token] = dictionary.word2idx[word]
                else:
                    ids[token] = dictionary.word2idx["<unk>"]
                token += 1

    return ids

