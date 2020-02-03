#!/bin/bash

export identifier=$1

#########################################################################

export path_data_A=/home/tkastylevsky/FASTA_files/repeatmasker/gallus_gallus/chr1_libchr1/chr1.fa.out.chr1_libchr1.gff
export path_data_B=/home/tkastylevsky/FASTA_files/repeatmasker/gallus_gallus/reference/galGal6.fa.out.ref_chr1.gff
export path_out=/home/tkastylevsky/results/results_bedtools
export pathsubScripts=/home/tkastylevsky/code/subscripts/bedtools

#########################################################################

echo "#!/bin/bash " > ${pathsubScripts}/sub_script_bedtools_${identifier}
echo "bedtools intersect -a ${path_data_A} -b ${path_data_B} -s -wo > ${path_out}/${identifier}.txt">> ${pathsubScripts}/sub_script_bedtools_${identifier}
echo "bedtools intersect -a ${path_data_A} -b ${path_data_B} -s -wo -f 0.80 -r > ${path_out}/${identifier}_80.txt">> ${pathsubScripts}/sub_script_bedtools_${identifier}
bash ${pathsubScripts}/sub_script_bedtools_${identifier}
