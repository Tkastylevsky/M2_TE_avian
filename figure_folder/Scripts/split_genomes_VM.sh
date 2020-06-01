#!/bin/bash 



export symbol_genome="galgal6_split"
#######
export path_genome=/mnt/tkastylevsky/data/galgal6_whole/galgal6_whole.fa
export path_out=/mnt/tkastylevsky/data/galgal6_split

export path_scripts=/mnt/tkastylevsky/code/
export path_subscripts=/mnt/tkastylevsky/code/subscripts/genome_split/
#######

echo "#!/bin/bash" > ${path_subscripts}sub_script_${symbol_genome}
echo "python ${path_scripts}split_genome.py ${path_genome} ${path_out}" >> ${path_subscripts}sub_script_${symbol_genome}


bash ${path_subscripts}sub_script_${symbol_genome}
