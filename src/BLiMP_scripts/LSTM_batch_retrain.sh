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



sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0039M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0039M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0039M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0039M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0039M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0079M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0079M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0079M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0079M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0079M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0156M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0156M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0156M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0156M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0156M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0313M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0313M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0313M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0313M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0313M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0625M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0625M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0625M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0625M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.0625M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.125M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.125M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.125M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.125M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.125M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.25M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.25M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.25M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.25M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.25M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.5M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.5M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.5M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.5M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_0.5M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_1M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_1M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_1M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_1M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_1M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_2M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_2M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_2M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_2M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_2M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_4M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_4M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_4M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_4M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_4M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_8M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_8M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_8M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_8M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_8M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_16M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_16M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_16M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_16M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_16M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_32M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_32M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_32M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_32M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_32M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_64M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_64M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_64M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_64M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_64M_5.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_1.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_2.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_3.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_4.sh

sbatch BLiMP_scripts/LSTM batch retrain/LSTM_retrain_83M_5.sh

