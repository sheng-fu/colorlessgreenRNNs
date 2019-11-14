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






尸