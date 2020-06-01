#!/bin/bash


#########################################################################

export path_data=/home/tkastylevsky/FASTA_files/genomes/
export path_ensembl_names=/home/tkastylevsky/results/ensembl_list/
export path_res=/home/tkastylevsky/results/results_final/bed_files_fig_4/genomes/
export path_code=/home/tkastylevsky/code/
#########################################################################
#la boucle while permet de parcourir le fichier qui contient le nom des espèces présentes dans ensembl. 

while IFS="" read -r p || [ -n "$p" ]
do
	
	export genome=`find ${path_data}${p} -maxdepth 1 -type f -name '*.dna.toplevel.fa'`
	python ${path_code}get_genome_bed.py ${genome} ${path_res} 

	

done < ${path_ensembl_names}ensembl_genomes.txt




