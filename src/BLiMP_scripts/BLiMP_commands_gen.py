import os
import re

import argparse

parser = argparse.ArgumentParser(add_help=False)

parser.add_argument('--tag', type=str, default='',
                       help='')

args = parser.parse_args()

tag = args.tag

for s in ['0.0039M', '0.0079M', '0.0156M', '0.0313M', '0.0625M', '0.125M', '0.25M', '0.5M', '1M', '2M', '4M', '8M', '16M', '32M', '64M', '83M']:
    for r in ['_1', '_2', '_3', '_4', '_5']:
        tag = s+r


        header = "#!/bin/bash\n#\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=1\n#SBATCH --time=20:00:00\n#SBATCH --job-name=scil\n#SBATCH --mail-type=END\n##SBATCH --mail-user=sfw268@nyu.edu\n#SBARCH --mem=8GB\n#SBATCH --output=slurm_%j.out\n#SBATCH --gres=gpu:1\n\n"

        outfile = open('BLiMP_scripts/LSTM batch eval/commands_by_token_'+tag+'.sh', 'w', newline='\n')
        outfile.write(header+'\n')

        main_command = 'python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --suffix best_model --cuda --checkpoint '

        checkpoint = '../models/hidden650_batch128_dropout0.2_lr20.0_retrained_'+tag+'.pt'
        output_folder = 'results/blimp_by_token_'+tag

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

