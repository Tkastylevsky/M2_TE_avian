#!/bin/bash

#########################################################################

export path_data=/home/tkastylevsky/trash/RepeatModeler/


#########################################################################

cd ${path_data}
cat ${path_data}* > all_libs.fa


usearch -cluster_fast ${path_data}all_libs.fa -sort length -strand both -id 0.8 -centroids ${path_data}all_libs_centroids_usearch.fa -clusters ${path_data}clusters -consout ${path_data}consensus_usearch.fa
