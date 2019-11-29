#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=72:00:00
#SBATCH --job-name=LSTM
#SBATCH --mail-type=END
##SBATCH --mail-user=sfw268@nyu.edu
#SBARCH --mem=300GB
#SBATCH --output=slurm_%j.out
#SBATCH --gres=gpu:1

python language_models/main.py --cuda --epochs 60 --nhid 650 --batch_size 128 --dropout 0.2 --lr 20.0 --data ../data/lm/English/ --save ../models/hidden650_batch128_dropout0.2_lr20.0_retrained_83M_3.pt --trainfile train.txt