import os
import re

header = "#!/bin/bash\n#\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=1\n#SBATCH --time=20:00:00\n#SBATCH --job-name=scil\n#SBATCH --mail-type=END\n##SBATCH --mail-user=sfw268@nyu.edu\n#SBARCH --mem=8GB\n#SBATCH --output=slurm_%j.out\n#SBATCH --gres=gpu:1\n\n"

outfile = open('BLiMP_scripts/commands_by_token_0.sh', 'w')
outfile.write(header+'\n')

main_command = 'python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --suffix best_model --cuda --checkpoint '

checkpoint = '../models/hidden650_batch128_dropout0.2_lr20.0_retrained0.pt'
output_folder = 'results/blimp_by_token_0'

outfile.write('mkdir -p ../' + output_folder+'\n\n')

path = '../data/blimp/txt_sentence/'
files = []

for r, d, f in os.walk(path):
    for file in f:
        if '.txt' in file:
            files.append(path+file)

for file in files:
    path_flag = '--path '+file[:-4]
    outfile_flag = '--outfile '+file[:-4]+'_output.tab'
    outfile.write(main_command + checkpoint+' ')
    outfile.write(path_flag+' ')
    outfile.write(re.sub('data/blimp/txt_sentence', output_folder, outfile_flag)+'\n\n')

