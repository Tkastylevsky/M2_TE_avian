#!/bin/bash

#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/genomes/
export path_res=/beegfs/data/tkastylevsky/results/RepeatModeler/
export pathsubScripts=/beegfs/data/tkastylevsky/scripts/subscripts

#########################################################################


for i in `ls ${path_data}`
do
	export FILE=${path_data}${i}/${i}-families.fa
	if test -f "$FILE"
	then
		echo "$FILE exist"
		cp $FILE ${path_res}
	fi
done
