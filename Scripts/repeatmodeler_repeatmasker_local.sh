#!/bin/bash

export database=$1

#########################################################################


export path_data=/home/tkastylevsky/FASTA_files/repeatmasker/gallus_gallus/chr1_libchr1_retry
export path_libs=/home/tkastylevsky/programs/rmsk_libs/Libraries
export pathsubScripts=/home/tkastylevsky/code/subscripts
export path_container=/home/tkastylevsky/programs/TETools-master
#########################################################################

echo "#!/bin/bash " > ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "cd">>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "cd ${path_data}">>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "BuildDatabase -name $1 -dir ${path_data} -engine rmblast" >>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "RepeatModeler -database $1 -LTRStruct -pa 8 -engine ncbi" >>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "cat ${path_libs}/RepeatMasker.lib ${path_data}$1-families.fa > ${path_data}/lib_$1_rmsk_combined.fasta" >>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
echo "RepeatMasker ${path_data}/chr1.fa -pa 8 -s -lib ${path_data}/lib_$1_rmsk_combined.fasta" >>  ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry

bash ${pathsubScripts}/sub_script_annot_chr1_rmsk_retry
 
