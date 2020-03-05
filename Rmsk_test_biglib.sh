#!/bin/bash 

#SBATCH --job-name=rmsk_galgal6_whole
#SBATCH --partition=normal
#SBATCH --output=/beegfs/data/tkastylevsky/trash/out_galgal6_biglib
#SBATCH --error=/beegfs/data/tkastylevsky/trash/err_galgal6_biglib
#SBATCH --cpus-per-task=16
#SBATCH --time=10:00:00
#SBATCH --mem=32G

source /beegfs/home/tkastylevsky/.bashrc
cd /beegfs/data/tkastylevsky/trash/galgal6_test_avian_lib
singularity exec /beegfs/data/tkastylevsky/rmsk.sif RepeatMasker galgal6_whole_avianlib.fa -pa 16 -s -lib library.lib

