import os
import re

header = "#!/bin/bash\n#\n##SBATCH --nodes=1\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=1\n#SBATCH --cpus-per-task=2\n#SBATCH --time=72:00:00\n#SBATCH --mem=64GB\n#SBATCH --job-name=LA\n#SBATCH --mail-type=END\n##SBATCH --mail-user=sfw268@nyu.edu\n#SBATCH --output=slurm_%j.out"


outfile = open('BLiMP_scripts/commands_by_token.sh', 'w')
outfile.write(header)

main_command = 'python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --suffix best_model --cuda --checkpoint '

checkpoint = '../models/hidden650_batch128_dropout0.2_lr20.0.pt'
output_folder = 'results/blimp_by_token'

path = '../data/blimp/txt_sentence/'
files = []

for r, d, f in os.walk(path):
    for file in f:
        if '.txt' in file:
            files.append(path+file)

for file in files:
    path_flag = '--path '+file[:-4]
    outfile_flag = '--outfile '+file[:-4]+'_output.tab'
    outfile.write(main_command + checkpoint)
    outfile.write(path_flag+' ')
    outfile.write(re.sub('data/blimp/txt_sentence', output_folder, outfile_flag)+'\n\n')

