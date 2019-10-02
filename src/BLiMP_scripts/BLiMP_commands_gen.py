import os

header = "#!/bin/bash\n#\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=1\n#SBATCH --time=20:00:00\n#SBATCH --job-name=scil\n#SBATCH --mail-type=END\n##SBATCH --mail-user=sfw268@nyu.edu\n#SBARCH --mem=8GB\n#SBATCH --output=slurm_%j.out\n#SBATCH --gres=gpu:1\n\n"

paths = ['../data/sent_pair/txt_sentence/', '../data/sent_pair/txt_prefix/', '../data/sent_pair/txt_two_prefix/']

outfile = open('BLiMP_scripts/commands_by_sentence.sh', 'w')
outfile.write(header)

main_command = 'python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda '

files = []

for path in paths:
    for r, d, f in os.walk(path):
        for file in f:
            if '.txt' in file:
                files.append(path+file)

for file in files:
    path_flag = '--path '+file[:-4]
    outfile_flag = '--outfile '+file[:-4]+'_output.tab'
    outfile.write(main_command)
    outfile.write(path_flag+' ')
    outfile.write(outfile_flag+'\n\n')

outfile = open('BLiMP_scripts/commands_by_token.sh', 'w')
outfile.write(header)

main_command = 'python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda '

path = '../data/sent_pair/txt_sentence/'
files = []

for r, d, f in os.walk(path):
    for file in f:
        if '.txt' in file:
            files.append(path+file)

for file in files:
    path_flag = '--path '+file[:-4]
    outfile_flag = '--outfile '+file[:-4]+'_output.tab'
    outfile.write(main_command)
    outfile.write(path_flag+' ')
    outfile.write(outfile_flag+'\n\n')

