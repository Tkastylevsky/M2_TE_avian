#!/bin/bash
export path_data=/beegfs/data/tkastylevsky/data/genomes/
for i in `ls ${path_data}`
do
	cd ${path_data}${i}
	find . -type d -name "RM*" -exec rm -rf {} \;
	cd ..
done
