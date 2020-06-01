#!/bin/bash

#########################################################################

export path_data=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/libs/

export path_dfam=/beegfs/data/tkastylevsky/data/repeatmasker_libs/
#########################################################################

cd ${path_data}
cp ${path_dfam}RepeatMasker.lib  ${path_data}
cat ${path_data}* > ../all_libs.fa
