#!/bin/bash

#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/genomes/
export path_res=/beegfs/data/tkastylevsky/results/Repeatmasker/
export path_ensembl_names=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/

export path_hocco=/beegfs/data/tkastylevsky/data/hocco_genome/Pauxi_pauxi
#########################################################################

export count
while IFS="" read -r p || [ -n "$p" ]
do
	
	cp ${path_data}${p}/*.out ${path_res}
	cp ${path_data}${p}/*.tbl ${path_res}

done < ${path_ensembl_names}ensembl_genomes.txt


cp ${path_hocco}/*.out ${path_res}
cp ${path_hocco}/*.tbl ${path_res}

