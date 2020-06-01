#!/bin/bash

#########################################################################

export path_data=/home/tkastylevsky/results/ensembl_lib/


#########################################################################



usearch -cluster_fast ${path_data}all_libs.fa -sort length -strand both -id 0.8 -centroids ${path_data}all_libs_centroids_usearch.fa -consout ${path_data}consensus_usearch.fa


#replace retroposon with LINE. 
sed -i 's/Retroposon/LINE/g' ${path_data}all_libs_centroids_usearch.fa
