#!/bin/bash

export path_data=/home/tkastylevsky/trash/RepeatModeler/
export path_res=/home/tkastylevsky/results/Tesorter_out/libs_avian_fusion/

cd ${path_res}
TEsorter ${path_data}consensus_usearch.fa

