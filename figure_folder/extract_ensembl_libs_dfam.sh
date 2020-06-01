#!/bin/bash

#########################################################################

export path_data=/beegfs/data/tkastylevsky/data/genomes/
export path_res=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/libs/
export path_ensembl_names=/beegfs/data/tkastylevsky/results/RepeatModeler/ensembl_libraries/
export path_dfam=/beegfs/data/tkastylevsky/data/repeatmasker_libs/

export path_hocco=/beegfs/data/tkastylevsky/data/hocco_genome/Pauxi_pauxi
#########################################################################

export count
while IFS="" read -r p || [ -n "$p" ]
do
	export FILE=${path_data}${p}/${p}-families.fa
	if test -f "$FILE"
	then
		expr='/^>.*#/{sub(/^>[^#]+/, ">"${p}"_" ++c)} 1'
		awk ${expr} $FILE > ${path_res}${p}-families.fa

	fi
pwd
done < ${path_ensembl_names}ensembl_genomes.txt


awk -v sp=Pauxi_pauxi '/^>.*#/{sub(/^>[^#]+/, ">"sp"_" ++c)} 1' ${path_hocco}/Pauxi_pauxi-families.fa > ${path_res}Pauxi_pauxi-families.fa

cd ${path_res}

cp ${path_dfam}RepeatMasker.lib  ${path_res}
cat ${path_res}* > ../all_libs.fa
