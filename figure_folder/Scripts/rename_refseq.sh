#!/bin/bash
export path_data=/beegfs/data/tkastylevsky/data/genomes/
for i in `ls ${path_data}`
do
	cd ${path_data}${i}
	for f in *.fna; do mv -n "$f" "${f/.fna/.fa}"; done
	cd ..
done


