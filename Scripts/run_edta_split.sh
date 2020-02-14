#!/bin/bash

export database=$1

#########################################################################

export path_data=/beegfs/data/tkastylevsky/genomes/EDTA/gallus_gallus/chr1/
export pathScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################

for i in ltr tir helitron
do 
	echo "#!/bin/bash " > ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --job-name=EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --output=${pathScripts}/std_out_EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --error=${pathScripts}/std_err_EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --cpus-per-task=16" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --time=5:00:00" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --mem=10G" >>  ${pathScripts}/bsub_script_EDTA_${database}$i

	echo "source /beegfs/home/tkastylevsky/.bashrc" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "conda activate EDTA" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "cd ${path_data}" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "EDTA_raw.pl --genome ${database} --type $i --threads 16" >>  ${pathScripts}/bsub_script_EDTA_${database}$i

	sbatch ${pathScripts}/bsub_script_EDTA_${database}$i
done


