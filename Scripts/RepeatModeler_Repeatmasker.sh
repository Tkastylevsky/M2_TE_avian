#!/bin/bash

export database=$1

#########################################################################

export path=/beegfs/data/tkastylevsky/genomes/gallus_gallus/
export path_data=${path}whole/
export path_libs=/beegfs/data/tkastylevsky/data/repeatmasker_libs/
export path_contener=/beegfs/data/tkastylevsky/
export pathScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################



echo "#!/bin/bash " > ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --job-name=rmsk_${database}" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --output=${pathScripts}/std_out_rmsk_${database}" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --error=${pathScripts}/std_err_rmsk_${database}" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --cpus-per-task=16" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --time=100:00:00" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "#SBATCH --mem=40G" >>  ${pathScripts}/bsub_script_Rmsk_${database}

echo "cd ${path_data}" >> ${pathScripts}/bsub_script_Rmsk_${database}
echo "singularity exec ${path_contener}rmsk.sif BuildDatabase -name ${database} -dir ${path_data} -engine rmblast" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "singularity exec ${path_contener}rmsk.sif RepeatModeler -database ${database} -LTRStruct -pa 16 -engine ncbi" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "cat ${path_libs}RepeatMasker.lib ${path_data}${database}-families.fa > ${path_data}lib_${database}_rmsk_combined.lib" >>  ${pathScripts}/bsub_script_Rmsk_${database}
echo "singularity exec ${path_contener}rmsk.sif RepeatMasker ${path_data}${database} -pa 16 -s -lib ${path_data}lib_${database}_rmsk_combined.fasta" >>  ${pathScripts}/bsub_script_Rmsk_${database}



sbatch ${pathScripts}/bsub_script_Rmsk_${database}
 
