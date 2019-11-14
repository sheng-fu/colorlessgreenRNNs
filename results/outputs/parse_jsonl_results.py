import json
import pandas as pd

import glob
jsonls = glob.glob("*.jsonl")

def parse_jsonl(path):

    lstm_1prefix = open(path, 'r')
    lstm_1prefix = lstm_1prefix.readlines()

    lstm_1prefix_dict = []

    for i in lstm_1prefix:
        lstm_1prefix_dict.append(json.loads(i))

    lstm_1prefix_pd = pd.DataFrame.from_dict(lstm_1prefix_dict)
    lstm_1prefix_pd.to_csv(path[:-5]+'tab', sep = "\t", index = False)


for i in jsonls:
    parse_jsonl(i)

exit()

parse_jsonl('blimp-lstm_oneprefix_peephole.jsonl')
parse_jsonl('blimp-lstm_twoprefix_peephole.jsonl')
parse_jsonl('blimp-lstm_simplelm_peephole.jsonl')

parse_jsonl('blimp-lstm_oneprefix_peephole.jsonl')
parse_jsonl('blimp-lstm_twoprefix_peephole.jsonl')
parse_jsonl('blimp-lstm_simplelm_peephole.jsonl')