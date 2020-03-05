#!/bin/bash
export path_data=/beegfs/data/tkastylevsky/data/genomes/
for i in `ls ${path_data}`
do
	cd ${path_data}${i}
	gunzip `ls ${path_data}${i}`
	cd ..
done
