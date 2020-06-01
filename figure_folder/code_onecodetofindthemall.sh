#!/bin/bash


#dependencies : one code to find them all
export file_name=Gallus_gallus.GRCg6a.dna.toplevel.fa.out
export path_rmsk_out=/home/tkastylevsky/results/avian_lib_filtered_out/Gallus_gallus.GRCg6a.dna.toplevel.fa.out
export path_program=/home/tkastylevsky/programs/Onecodetofindthemall
export path_out=/home/tkastylevsky/results/avian_lib_filtered_out/
export symbol=Gallus_gallus.GRCg6a


mkdir ${path_out}${symbol}_OCTFTA
cd ${path_out}${symbol}_OCTFTA
cp ${path_rmsk_out} ${path_out}${symbol}_OCTFTA
${path_program}/build_dictionary.pl --rm ${path_out}${symbol}_OCTFTA/${file_name} > ${path_out}${symbol}_OCTFTA/dic_out
${path_program}/one_code_to_find_them_all.pl --rm ${path_out}${symbol}_OCTFTA/${file_name} --ltr ${path_out}${symbol}_OCTFTA/dic_out



