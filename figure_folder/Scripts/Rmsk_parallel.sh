#!/bin/bash


#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/genomes/
export path_contener=/beegfs/data/tkastylevsky/
export path_ensembl_names=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/
export pathsubScripts=/beegfs/data/tkastylevsky/scripts/subscripts/RepeatMasker
export path_lib=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/
export path_hocco=/beegfs/data/tkastylevsky/data/hocco_genome/
export path_res=/beegfs/data/tkastylevsky/results/Repeatmasker/
#########################################################################
#la boucle while permet de parcourir le fichier qui contient le nom des espèces présentes dans ensembl. 

while IFS="" read -r p || [ -n "$p" ]
do
	echo "#!/bin/bash " > ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --job-name=rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --partition=normal" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --output=${pathsubScripts}/std_out_rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --error=${pathsubScripts}/std_err_rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --cpus-per-task=32" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --time=20:00:00" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "#SBATCH --mem=40G" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
	
	echo "cd ${path_data}${p}" >> ${pathsubScripts}/bsub_script_Rmsk_${p}
	export genome=`find ${path_data}${p} -maxdepth 1 -type f -name '*.fa' ! -name '*families*.fa' ! -name '*lib.fa'`
	echo "cp ${path_lib}lib_avian_filtered.fa ${path_data}${p}" >> ${pathsubScripts}/bsub_script_Rmsk_${p}
	echo "singularity exec ${path_contener}rmsk.sif RepeatMasker ${genome} -pa 8 -s -lib lib_avian_filtered.fa" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}

	sbatch ${pathsubScripts}/bsub_script_Rmsk_${p}
	

done < ${path_ensembl_names}ensembl_genomes.txt



p=Pauxi_pauxi
echo "#!/bin/bash " > ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --job-name=rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --partition=normal" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --output=${pathsubScripts}/std_out_rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --error=${pathsubScripts}/std_err_rmsk_${p}" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --cpus-per-task=32" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --time=20:00:00" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "#SBATCH --mem=40G" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}

echo "cd ${path_hocco}${p}" >> ${pathsubScripts}/bsub_script_Rmsk_${p}
export genome=`find ${path_hocco}${p} -maxdepth 1 -type f -name '*.fa' ! -name '*families*.fa' ! -name '*lib.fa'`
echo "cp ${path_lib}lib_avian_filtered.fa ${path_hocco}${p}" >> ${pathsubScripts}/bsub_script_Rmsk_${p}
echo "singularity exec ${path_contener}rmsk.sif RepeatMasker ${genome} -pa 8 -s -lib lib_avian_filtered.fa" >>  ${pathsubScripts}/bsub_script_Rmsk_${p}

sbatch ${pathsubScripts}/bsub_script_Rmsk_${p}























 
