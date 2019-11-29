header = "#!/bin/bash\n#\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=1\n#SBATCH --time=72:00:00\n#SBATCH --job-name=LSTM\n#SBATCH --mail-type=END\n##SBATCH --mail-user=sfw268@nyu.edu\n#SBARCH --mem=300GB\n#SBATCH --output=slurm_%j.out\n#SBATCH --gres=gpu:1\n\n"

main = "python language_models/main.py --cuda --epochs 60 --nhid 650 --batch_size 128 --dropout 0.2 --lr 20.0 --data ../data/lm/English/ --save ../models/hidden650_batch128_dropout0.2_lr20.0_retrained"

sizes = ['0.0039M', '0.0079M', '0.0156M', '0.0313M', '0.0625M', '0.125M', '0.25M', '0.5M', '1M', '2M', '4M', '8M', '16M', '32M', '64M']
runs = ['1', '2', '3', '4', '5']

outfile_main = open('BLiMP_scripts/LSTM_batch_retrain.sh', 'w', newline='\n')
outfile_main.write(header+'\n\n')

for size in sizes:
    for run in runs:
        model_suffix = '_'+size+'_'+run+'.pt '
        trainfile = '--trainfile train_'+size+'_'+run+'.txt'

        outfile = open('BLiMP_scripts/LSTM batch retrain/LSTM_retrain_'+size+'_'+run+'.sh', 'w', newline='\n')
        outfile.write(header)
        outfile.write(main)
        outfile.write(model_suffix)
        outfile.write(trainfile)

        outfile_main.write('sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_'+size+'_'+run+'.sh\n\n')


for run in runs:
    model_suffix = '_83M_'+run+'.pt '
    trainfile = '--trainfile train.txt'

    outfile = open('BLiMP_scripts/LSTM batch retrain/LSTM_retrain'+'_83M_'+run+'.sh', 'w', newline='\n')
    outfile.write(header)
    outfile.write(main)
    outfile.write(model_suffix)
    outfile.write(trainfile)

    outfile_main.write('sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_'+run+'.sh\n\n')

