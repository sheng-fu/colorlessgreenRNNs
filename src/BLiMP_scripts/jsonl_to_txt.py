import json
import pandas as pd
import re
import os
from nltk.tokenize import word_tokenize


path = '../data/blimp'

jsonls = []
for r, d, f in os.walk(path+'/jsonl'):
    for file in f:
        if '.jsonl' in file:
             jsonls.append(file)

print(jsonls)

for jsonl in jsonls:
    infile = open(path+'/jsonl/'+jsonl)
    infile = infile.readlines()
    infile_json = [json.loads(x) for x in infile]

    sentences = []

    outfile = open(path+'/txt_sentence/'+jsonl[:-6]+'.txt', 'w')

    for i in infile_json:
        outfile.write(' '.join(word_tokenize(i['sentence_good'])))
        outfile.write(' <eos>\n') 
        outfile.write(' '.join(word_tokenize(i['sentence_bad'])))
        outfile.write(' <eos>\n')       

    if infile_json[0]['one_prefix_method'] == True:
        outfile = open(path+'/txt_one_prefix/'+jsonl[:-6]+'.txt', 'w')
        for i in infile_json:
            if 'one_prefix_word_good' in i.keys() and 'one_prefix_word_bad' in i.keys():
                good_form = ' '.join(word_tokenize(i['one_prefix_prefix'])) + ' ' + ' '.join(word_tokenize(i['one_prefix_word_good']))
                bad_form = ' '.join(word_tokenize(i['one_prefix_prefix'])) + ' ' + ' '.join(word_tokenize(i['one_prefix_word_bad']))
                outfile.write(good_form)
                outfile.write(' <eos>\n')
                outfile.write(bad_form)
                outfile.write(' <eos>\n')

    if infile_json[0]['two_prefix_method'] == True:
        print('check')
        outfile = open(path+'/txt_two_prefix/'+jsonl[:-6]+'.txt', 'w')
        for i in infile_json:
             if 'two_prefix_prefix_good' in i.keys() and 'two_prefix_prefix_good' in i.keys():
                good_form = ' '.join(word_tokenize(i['two_prefix_prefix_good'])) + ' ' + ' '.join(word_tokenize(i['two_prefix_word']))
                bad_form = ' '.join(word_tokenize(i['two_prefix_prefix_bad'])) + ' ' + ' '.join(word_tokenize(i['two_prefix_word']))
                outfile.write(good_form)
                outfile.write(' <eos>\n')
                outfile.write(bad_form)
                outfile.write(' <eos>\n')       
   




