#!/bin/bash

export database=$1

#########################################################################

export path=/beegfs/data/tkastylevsky/
export path_data=${path}/genomes/gallus_gallus
export path_libs=${path}/data/repeatmasker_libs
export pathResults=${path}/results/genome_assembly_tests/SOAPdenovo/${genomeprefix}
export pathScripts=${path}/scripts/genome_assembly

#########################################################################

echo "#!/bin/bash " > ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --job-name=rmsk_$1" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --output=${pathScripts}/std_out_rmsk_$1" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --error=${pathScripts}/std_err_rmsk_$1" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --cpus-per-task=16" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --time=100:00:00" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --mem=40G" >>  ${pathScripts}/bsub_script_test_SOAPdenovo    

echo "BuildDatabase -name $1 -dir ${path_data} -engine rmblast" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "RepeatModeler -database $1 -LTRStruct -pa 16 -engine ncbi" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "cat ${path_libs}/RepeatMasker.lib ${path_data}$1-families.fa > lib_$1_rmsk_combined.fasta" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "RepeatMasker ${path_data} -pa 16 -s -lib ${path_libs}/lib_$1_rmsk_combined.fasta" >>  ${pathScripts}/bsub_script_test_SOAPdenovo

sbatch ${pathScripts}/bsub_script_test_SOAPdenovo
 
