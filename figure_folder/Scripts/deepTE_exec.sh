#!/bin/bash

path_input="/home/tkastylevsky/trash/RepeatModeler/consensus_usearch.fa"
path_output="/home/tkastylevsky/results/deepTE_out/test_avian_fusion"
path_intermediary="/home/tkastylevsky/results/deepTE_out/test_avian_fusion"
path_program="/home/tkastylevsky/programs/deepTE/DeepTE"


cd ${path_program}
python DeepTE.py -d ${path_intermediary} -o ${path_output} -i ${path_input} -sp M -m M
