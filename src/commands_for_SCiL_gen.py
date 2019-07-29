import os

paths = ['../data/sent_pair/txt_sentence/', '../data/sent_pair/txt_prefix/']

outfile = open('commands_SciL.txt', 'w')

main_command = 'python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda '

files = []

for path in paths:
    for r, d, f in os.walk(path):
        for file in f:
            if '.txt' in file:
                files.append(path+file)

for file in files:
    path_flag = '--path '+file
    outfile_flag = '--outfile '+file[:-4]+'_output.tab'
    outfile.write(main_command)
    outfile.write(path_flag+' ')
    outfile.write(outfile_flag+'\n\n')
