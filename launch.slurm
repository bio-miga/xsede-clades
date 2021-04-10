#!/bin/bash
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=127
#SBATCH --export=ALL
#SBATCH -t 48:00:00
#SBATCH -A get144

cd "$SLURM_SUBMIT_DIR/$MIGA_CLADE"
. "$HOME/.miga_rc"
miga index_wf -o . -v -j 127

