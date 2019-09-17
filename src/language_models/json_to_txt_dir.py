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

    tokenization_regex = '(are|is|have|has|do|does|was|were|ca|could|wo)n\'t'

    for i in infile_json:
        temp = re.sub('(.$)', ' \\1 <eos>', i['sentence_good'].strip())
        outfile.write(re.sub(tokenization_regex, '\\1 n\'t', temp))
        outfile.write('\n')
        temp = re.sub('(.$)', ' \\1 <eos>', i['sentence_bad'].strip())
        outfile.write(re.sub(tokenization_regex, '\\1 n\'t', temp))     
        outfile.write('\n')


    if infile_json[0]['one_prefix_method'] == True:
        outfile = open(path+'/txt_prefix/'+jsonl[:-6]+'.txt', 'w')
        for i in infile_json:
            if 'one_prefix_word_good' in i.keys() and 'one_prefix_word_bad' in i.keys():
                good_form = i['one_prefix_prefix'].strip() + ' ' + i['one_prefix_word_good'].strip()
                bad_form = i['one_prefix_prefix'].strip() + ' ' + i['one_prefix_word_bad'].strip()
                outfile.write(re.sub(tokenization_regex, '\\1 n\'t', good_form))
                outfile.write('\n')
                outfile.write(re.sub(tokenization_regex, '\\1 n\'t', bad_form))
                outfile.write('\n')

    if infile_json[0]['two_prefix_method'] == True:
        print('check')
        outfile = open(path+'/txt_two_prefix/'+jsonl[:-6]+'.txt', 'w')
        for i in infile_json:
             if 'two_prefix_prefix_good' in i.keys() and 'two_prefix_prefix_good' in i.keys():
                good_form = i['two_prefix_prefix_good'].strip() + ' ' + i['two_prefix_word'].strip()
                bad_form = i['two_prefix_prefix_bad'].strip() + ' ' + i['two_prefix_word'].strip()
                outfile.write(re.sub(tokenization_regex, '\\1 n\'t', good_form))
                outfile.write('\n')
                outfile.write(re.sub(tokenization_regex, '\\1 n\'t', bad_form))
                outfile.write('\n')       
   




