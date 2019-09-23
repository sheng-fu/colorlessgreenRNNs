import json

f = open("..\\..\\results\\by_token\\anaphor_reconstruction_output_parsed_by_token.tab", "r")

##go over the to_token files
##find matching json files

data = []

for line in f:
    sp = line.split('\t')
    data.append({"sentence good": sp[0], "entropy good": json.loads(sp[1]), "logit good": json.loads(sp[2]),
                 "sentence bad": sp[3], "entropy bad": json.loads(sp[4]), "logit bad": json.loads(sp[5])})

outfile = open('test.txt', 'w') 

for i in data:
    json.dump(i, outfile) 
    outfile.write('\n')