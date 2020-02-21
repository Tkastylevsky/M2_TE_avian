#!/bin/bash

export database=$1

#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/avian_genomes/
export path_res=/beegfs/data/tkastylevsky/results/RepeatModeler/
export path_contener=/beegfs/data/tkastylevsky/
export pathsubScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################


for i in `ls ${path_data}`
do
	echo $i
	echo "#!/bin/bash " > ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --job-name=RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_RM_${i}
	echo "#SBATCH --output=${pathScripts}/std_out_RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --error=${pathScripts}/std_err_RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --cpus-per-task=16" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --time=100:00:00" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --mem=36G" >>  ${pathsubScripts}/bsub_script_RM_${i}

	echo "mkdir ${path_res}${i}" >> ${pathScripts}/bsub_script_RM_${database}
	echo "cd ${path_res}${i}" >> ${pathScripts}/bsub_script_RM_${database}
	echo "singularity exec ${path_contener}rmsk.sif BuildDatabase -name ${i} -dir ${path_data}${i} -engine rmblast" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "singularity exec ${path_contener}rmsk.sif RepeatModeler -database ${i} -LTRStruct -pa 16 -engine ncbi" >>  ${pathsubScripts}/bsub_script_RM_${i}

	sbatch ${pathsubScripts}/bsub_script_Rmsk_${i}
done

 
