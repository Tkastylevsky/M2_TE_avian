#!/bin/bash

export kmer=$1
export genomeprefix=$2

#########################################################################

export path=/beegfs/data/necsulea/IPLOSS
export pathResults=${path}/results/genome_assembly_tests/SOAPdenovo/${genomeprefix}
export pathScripts=${path}/scripts/genome_assembly

#########################################################################

echo "#!/bin/bash " > ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --job-name=SOAP_${kmer}" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --partition=normal" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --output=${pathScripts}/std_out_SOAP_${kmer}" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --error=${pathScripts}/std_err_SOAP_${kmer}" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --cpus-per-task=8" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --time=24:00:00" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
echo "#SBATCH --mem=20G" >>  ${pathScripts}/bsub_script_test_SOAPdenovo    
echo "SOAPdenovo-63mer all -s ${pathScripts}/configFile_SOAPdenovo_test_${genomeprefix}_${cloud} -o ${pathResults}/kmer${kmer} -p 8 -a 20 -K ${kmer}" >>  ${pathScripts}/bsub_script_test_SOAPdenovo
    
sbatch ${pathScripts}/bsub_script_test_SOAPdenovo

