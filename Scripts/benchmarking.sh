#!/bin/bash




###################################################################################################################

export symbol_A="whole_libavian"
export symbol_B="whole_libwhole"

###################################################################################################################

export path_data_A=/home/tkastylevsky/trash/trash/galgal6_test_avian_lib/galgal6_whole_avianlib.fa.out
export path_data_B=/home/tkastylevsky/FASTA_files/repeatmasker/gallus_gallus/gallus_whole_cluster/whole/galgal6_whole.fa.out
export chr="whole"
export path_out=/home/tkastylevsky/results/results_bedtools/
export path_res=/home/tkastylevsky/results/bedtools_analysis/


export path_scripts=/home/tkastylevsky/code/
export pathsubScripts=/home/tkastylevsky/code/subscripts/benchmarking

###################################################################################################################


echo "#!/bin/bash " > ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}


echo "python ${path_scripts}/out_to_bedtools.py ${path_data_A} $symbol_A $chr" >> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "python ${path_scripts}/out_to_bedtools.py ${path_data_B} $symbol_B $chr" >> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "bedtools intersect -a ${path_data_A}.$symbol_A.gff -b ${path_data_B}.$symbol_B.gff -s -wo > ${path_out}${symbol_A}_${symbol_B}.txt">> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "bedtools intersect -a ${path_data_A}.$symbol_A.gff -b ${path_data_B}.$symbol_B.gff -s -wo -f 0.80 -r > ${path_out}/${symbol_A}_${symbol_B}_80.txt">> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "python ${path_scripts}bedtool_analysis.py ${path_out} ${symbol_A} ${symbol_B} ${path_data_A}.${symbol_A}.csv ${path_data_B}.${symbol_B}.csv ${path_res}" >> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "Rscript ${path_scripts}bedtools_display.R ${path_res} ${symbol_A} ${symbol_B}" >> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}
echo "Rscript ${path_scripts}bedtools_missing_display.R ${path_res} ${path_data_A}.${symbol_A}.csv ${path_data_B}.${symbol_B}.csv ${symbol_A} ${symbol_B}" >> ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}

bash ${pathsubScripts}/sub_script_benchmark_${symbol_A}_${symbol_B}


