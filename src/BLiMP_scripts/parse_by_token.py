import json
from nltk.tokenize import word_tokenize

#get json file names

from os import listdir
from os.path import isfile, join

json_path = "../data/blimp/jsonl/"
result_path = "../results/blimp_by_token/"
outfile_path_lm = "blimp-lstm_simplelm_peephole.jsonl"
outfile_path_oneprefix = "blimp-lstm_oneprefix_peephole.jsonl"
outfile_path_twoprefix = "blimp-lstm_twoprefix_peephole.jsonl"

files = [f for f in listdir(json_path) if isfile(join(json_path, f)) and 'jsonl' in f]
print(files)


data_json = []

for file in files:
    print(file)
    result = open(join(result_path, file[:-6]+"_output_parsed_by_token.tab"), 'r', encoding = 'utf8').read().split('\n')
    result = [x.split("\t") for x in result]
    data = open(join(json_path, file), 'r', encoding = 'utf8').read().split('\n')
    data = [x for x in data if len(x) > 1]

    for i in range(len(data)):
        temp = json.loads(data[i])
        if temp["simple_LM_method"]:
            temp["lm_prob1"] = sum(json.loads(result[i][2]))
            temp["lm_prob2"] = sum(json.loads(result[i][5]))
        if temp["one_prefix_method"]:
            critical_position_good = len(word_tokenize(temp["one_prefix_prefix"] + ' ' + temp['one_prefix_word_good'])) - 1
            critical_position_bad = len(word_tokenize(temp["one_prefix_prefix"] + ' ' + temp['one_prefix_word_bad'])) - 1
            temp["crit_logits1"] = json.loads(result[i][2])[critical_position_good]
            temp["crit_logits2"] = json.loads(result[i][5])[critical_position_bad]    
            temp["prefix_logits1"] = sum(json.loads(result[i][2])[:critical_position_good])
            temp["prefix_logits2"] = sum(json.loads(result[i][5])[:critical_position_bad])
            temp["append_logits1"] = sum(json.loads(result[i][2])[critical_position_good+1:])
            temp["append_logits2"] = sum(json.loads(result[i][5])[critical_position_bad+1:])
            temp["appen_entropy1"] = sum(json.loads(result[i][1])[critical_position_good+1:])
            temp["appen_entropy2"] = sum(json.loads(result[i][4])[critical_position_bad+1:])
        if temp["two_prefix_method"]:
            critical_position_good = len(word_tokenize(temp["two_prefix_prefix_good"] + ' ' + temp['two_prefix_word'])) - 1
            critical_position_bad = len(word_tokenize(temp["two_prefix_prefix_bad"] + ' ' + temp['two_prefix_word'])) - 1
            temp["crit_logits1"] = json.loads(result[i][2])[critical_position_good]
            temp["crit_logits2"] = json.loads(result[i][5])[critical_position_bad]
            temp["append_logits1"] = sum(json.loads(result[i][2])[critical_position_good+1:])
            temp["append_logits2"] = sum(json.loads(result[i][5])[critical_position_bad+1:])
            temp["appen_entropy1"] = sum(json.loads(result[i][1])[critical_position_good+1:])
            temp["appen_entropy2"] = sum(json.loads(result[i][4])[critical_position_bad+1:])        
            temp["prefix_logits1"] = sum(json.loads(result[i][2])[:critical_position_good])
            temp["prefix_logits2"] = sum(json.loads(result[i][5])[:critical_position_bad])
        
        data_json.append(temp)

outfile_lm = open(outfile_path_lm, 'w', encoding = 'utf8')  
outfile_oneprefix = open(outfile_path_oneprefix, 'w', encoding = 'utf8') 
outfile_twoprefix = open(outfile_path_twoprefix, 'w', encoding = 'utf8') 

for d in data_json:
    if d['simple_LM_method']:
        json.dump(d, outfile_lm) 
        outfile_lm.write('\n')
    if d['one_prefix_method']:
        json.dump(d, outfile_oneprefix) 
        outfile_oneprefix.write('\n')
    if d['two_prefix_method']:
        json.dump(d, outfile_twoprefix) 
        outfile_twoprefix.write('\n')



