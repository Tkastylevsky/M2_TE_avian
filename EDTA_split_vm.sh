#!/bin/bash

export database=galgal6_chr1.fa

#########################################################################

export path_data=/mnt/tkastylevsky/results/EDTA
export path_env=/mnt/tkastylevsky/programs/EDTA_env
export path_EDTA=/mnt/tkastylevsky/programs/EDTA/
#########################################################################

####you must activate the conda env first !

cd ${path_data}

for i in ltr tir helitron
do 
	nohup ${path_EDTA}EDTA_raw.pl --genome ${database} --type $i --threads 10 > std_out_${database}_$i &

done

wait

nohup ${path_EDTA}EDTA.pl --genome ${database} --overwrite 0 --threads 32 --sensitive 1 > std_out_${database}_all &


nohup ${path_EDTA}EDTA.pl --genome ${database} --step anno --anno 1 --overwrite 0 --threads 32 --sensitive 1 > std_out_${database}_all_anno &



