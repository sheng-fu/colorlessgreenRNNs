import json
import pandas as pd
import re

infile = open('../../data/sent_pair/simple_anaphor_number_agreement.jsonl') 
infile = infile.readlines()

infile_json = [json.loads(x) for x in infile]

sentences = []

outfile = open('../../data/sent_pair/test_simp.txt', 'w')

for i in infile_json:
    outfile.write(re.sub('(\\.)', ' \\1 <eos>', i['sentence_good']))
    outfile.write('\n')
    outfile.write(re.sub('(\\.)', ' \\1 <eos>', i['sentence_bad']))
    outfile.write('\n')


