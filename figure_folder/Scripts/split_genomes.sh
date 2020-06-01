#!/bin/bash 



export symbol_genome="galgal6"
#######
export path_genome=/home/tkastylevsky/trash/samtools_test/galGal6.fa
export path_out=/home/tkastylevsky/trash/samtools_test/

export path_scripts=/home/tkastylevsky/code/
export path_subscripts=/home/tkastylevsky/code/subscripts/genome_split/
#######

echo "#!/bin/bash" > ${path_subscripts}sub_script_${symbol_genome}
echo "python ${path_scripts}split_genome.py ${path_genome} ${path_out}" >> ${path_subscripts}sub_script_${symbol_genome}


bash ${path_subscripts}sub_script_${symbol_genome}
