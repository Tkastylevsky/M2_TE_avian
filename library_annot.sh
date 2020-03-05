#!/bin/bash

export path_lib=/home/tkastylevsky/trash/RepeatModeler/
export path_contener=/home/tkastylevsky/FASTA_files/
export path_out=/home/tkastylevsky/results/TEclassifier_out/

cd ${path_out}
singularity exec ${path_contener}rmsk.sif RepeatClassifier -consensi ${path_lib}consensus_usearch.fa
