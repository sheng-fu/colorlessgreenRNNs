import json
import pandas as pd
import re
import os

path = '../../data/sent_pair'

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
        outfile.write(re.sub('(\\.)', '\\1 <eos>', i['sentence_good']))
        outfile.write('\n')
        outfile.write(re.sub('(\\.)', '\\1 <eos>', i['sentence_bad']))
        outfile.write('\n')


    if infile_json[0]['one_prefix_method'] == True:
        outfile = open(path+'/txt_prefix/'+jsonl[:-6]+'.txt', 'w')
        for i in infile_json:
            if 'one_prefix_word_good' in i.keys() and 'one_prefix_word_bad' in i.keys():
                good_form = i['one_prefix_prefix'] + ' ' + i['one_prefix_word_good'] 
                bad_form = i['one_prefix_prefix'] + ' ' + i['one_prefix_word_bad'] 
                outfile.write(good_form)
                outfile.write('\n')
                outfile.write(bad_form)
                outfile.write('\n')
   




