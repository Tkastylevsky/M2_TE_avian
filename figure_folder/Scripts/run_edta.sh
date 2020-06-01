#!/bin/bash

export database=$1

#########################################################################

export path_data=/beegfs/data/tkastylevsky/genomes/EDTA/gallus_gallus/chr1/
export pathScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################



echo "#!/bin/bash " > ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --job-name=EDTA_${database}" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --output=${pathScripts}/std_out_EDTA_${database}" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --error=${pathScripts}/std_err_EDTA_${database}" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --cpus-per-task=32" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --time=100:00:00" >>  ${pathScripts}/bsub_script_EDTA_${database}
echo "#SBATCH --mem=10G" >>  ${pathScripts}/bsub_script_EDTA_${database}

echo "source /beegfs/home/tkastylevsky/.bashrc" >> ${pathScripts}/bsub_script_EDTA_${database}
echo "conda activate EDTA" >> ${pathScripts}/bsub_script_EDTA_${database}
echo "cd ${path_data}" >> ${pathScripts}/bsub_script_EDTA_${database}
echo "EDTA.pl --genome ${database} --anno 1 --sensitive 1 --threads 32" >>  ${pathScripts}/bsub_script_EDTA_${database}

sbatch ${pathScripts}/bsub_script_EDTA_${database}
