#!/bin/bash



#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/genomes/
export path_res=/beegfs/data/tkastylevsky/results/RepeatModeler/
export path_contener=/beegfs/data/tkastylevsky/
export pathsubScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################


for i in `ls ${path_data}`
do
	echo "#!/bin/bash " > ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --job-name=RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --partition=normal" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --output=${pathsubScripts}/std_out_RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --error=${pathsubScripts}/std_err_RM_${i}" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --cpus-per-task=16" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --time=100:00:00" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "#SBATCH --mem=36G" >>  ${pathsubScripts}/bsub_script_RM_${i}
	
	echo "mkdir ${path_res}${i}" >> ${pathsubScripts}/bsub_script_RM_${i}
	echo "cd ${path_data}${i}" >> ${pathsubScripts}/bsub_script_RM_${i}
	echo "singularity exec ${path_contener}rmsk.sif BuildDatabase -name ${i} -dir ${path_data}${i} -engine rmblast" >>  ${pathsubScripts}/bsub_script_RM_${i}
	echo "singularity exec ${path_contener}rmsk.sif RepeatModeler -database ${i} -LTRStruct -pa 16 -engine ncbi" >>  ${pathsubScripts}/bsub_script_RM_${i}

	sbatch ${pathsubScripts}/bsub_script_RM_${i}
done

 
