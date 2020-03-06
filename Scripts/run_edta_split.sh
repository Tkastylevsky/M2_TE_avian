#!/bin/bash

export database=galgal6_chr1.fa

#########################################################################

export path_data=/beegfs/data/tkastylevsky/genomes/EDTA/gallus_gallus/chr1
export pathScripts=/beegfs/data/tkastylevsky/scripts/subscripts/EDTA
export pathjobid=/beegfs/data/tkastylevsky/scripts/jobID
export path_env=/beegfs/data/tkastylevsky/conda_envs/env_EDTA
#########################################################################



for i in ltr tir helitron
do 
	echo "#!/bin/bash " > ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --job-name=EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --output=${pathScripts}/std_out_EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --error=${pathScripts}/std_err_EDTA_${database}$i" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --cpus-per-task=32" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --time=5:00:00" >>  ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "#SBATCH --mem=10G" >>  ${pathScripts}/bsub_script_EDTA_${database}$i

	echo "source /beegfs/home/tkastylevsky/.bashrc" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "conda activate ${path_env}" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "cd ${path_data}" >> ${pathScripts}/bsub_script_EDTA_${database}$i
	echo "EDTA_raw.pl --genome ${database} --type $i --threads 32" >>  ${pathScripts}/bsub_script_EDTA_${database}$i

	sbatch ${pathScripts}/bsub_script_EDTA_${database}$i > ${pathjobid}/jobID_EDTA_${database}$i
done

jobID_ltr=$(grep -o '[[:digit:]]\+' ${pathjobid}/jobID_EDTA_${database}ltr)
jobID_tir=$(grep -o '[[:digit:]]\+' ${pathjobid}/jobID_EDTA_${database}tir)
jobID_helitron=$(grep -o '[[:digit:]]\+' ${pathjobid}/jobID_EDTA_${database}helitron)

echo "#!/bin/bash " > ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --job-name=EDTA_${database}_total" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --output=${pathScripts}/std_out_EDTA_${database}_total" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --error=${pathScripts}/std_err_EDTA_${database}_total" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --cpus-per-task=16" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --time=100:00:00" >>  ${pathScripts}/bsub_script_EDTA_${database}_total
echo "#SBATCH --mem=30G" >>  ${pathScripts}/bsub_script_EDTA_${database}_total

echo "source /beegfs/home/tkastylevsky/.bashrc" >> ${pathScripts}/bsub_script_EDTA_${database}_total
echo "conda activate ${path_env}" >> ${pathScripts}/bsub_script_EDTA_${database}_total
echo "cd ${path_data}" >> ${pathScripts}/bsub_script_EDTA_${database}_total
echo "EDTA.pl --genome ${database} --overwrite 0 --threads 16 --anno 1" >>  ${pathScripts}/bsub_script_EDTA_${database}_total

sbatch -d afterany:${jobID_ltr}:${jobID_tir}:${jobID_helitron} ${pathScripts}/bsub_script_EDTA_${database}_total




