#!/bin/bash 



cd /home/centos/data

####
export project="galgal6_split"
####
export path_chunks=galgal6_split
export path=/home/centos/results/
####
mkdir ${path}${project}
export count=0
cd ${path_chunks}
for i in *.fa
do 
	
	mkdir ../../results/${project}/group_${count}
	cd ../../results/${project}/group_${count}
	ln -s ../../../data/${path_chunks}/$i project.fa
	export count=$((${count}+1))
	export path_project=`pwd`
	echo "
[repet_env]
repet_version: 3.0
repet_host: localhost
repet_user: orepet
repet_pw: repet_pw
repet_db: repet
repet_port: 3306
repet_job_manager: slurm

[project]
project_name: project
project_dir: ${path_project}

[prepare_batches]
resources:
tmpDir:
chunk_length: 200000
chunk_overlap: 10000
min_nb_seq_per_batch: 5
clean: yes

[self_align]
resources:
tmpDir:
copy: no
blast: ncbi
Evalue: 1e-300
length: 100
identity: 90
filter_HSP: yes
min_Evalue: 1e-300
min_identity: 90
min_length: 100
max_length: 20000
clean: yes

[cluster_HSPs]
resources:
tmpDir:
Grouper_nbGroup: 1
Grouper_coverage: 0.95
Grouper_include: 2
Grouper_maxJoinLength: 30000
minNbSeqPerGroup: 3
nbLongestSeqPerGroup: 20
maxSeqLength: 20000
clean: yes

[structural_search]
resources:
tmpDir:
minLTRSize: 100
maxLTRSize: 1000
minElementSize: 1100
maxElementSize: 16000
LTR_similarity: 90
overlaps_handling: best
clean: yes

[structural_search_clustering]
resources:
tmpDir:
type: blastclust
MCL_inflation: 1.5
MCL_coverage: 0
clean: yes

[build_consensus]
resources:
tmpDir:
minBasesPerSite: 2
clean: yes

[detect_features]
resources: 
tmpDir: 
term_rep: yes
polyA: yes
tand_rep: yes
orf: yes
blast: ncbi
TE_BLRn: yes
TE_BLRtx: yes
TE_nucl_bank: repbase20.05_ntSeq_cleaned_TE.fsa
TE_BLRx: yes
TE_prot_bank: repbase20.05_aaSeq_cleaned_TE.fsa
TE_HMMER: yes
TE_HMM_profiles: ProfilesBankForREPET_Pfam27.0_GypsyDB.hmm
TE_HMMER_evalue: 10
HG_BLRn: no
HG_nucl_bank: <bank_of_host_genes>
rDNA_BLRn: no
rDNA_bank: <bank_of_rDNA_sequences_from_eukaryota>
tRNA_scan: no
TRFmaxPeriod: 15
RepScout: no
RepScout_bank: <bank_of_RepeatScout>
clean: yes

[classif_consensus]
resources:
tmpDir:
limit_job_nb: 0
max_profiles_evalue: 1e-3
min_TE_profiles_coverage: 20
min_HG_profiles_coverage: 75
max_helitron_extremities_evalue: 1e-3
min_TE_bank_coverage: 5
min_HG_bank_coverage: 95
min_HG_bank_identity: 90
min_rDNA_bank_coverage: 95
min_rDNA_bank_identity: 90
min_SSR_coverage: 0.75
max_SSR_size: 100
remove_redundancy: yes
min_redundancy_identity: 95
min_redundancy_coverage: 98
rev_complement: yes
add_wicker_code: yes
add_noCat_bestHitClassif: no
clean: yes

[filter_consensus]
resources: 
tmpDir: 
filter_SSR: yes
length_SSR: 0
filter_unclassified: yes
filter_unclassified_max_fragments: 10
filter_host_gene: no
filter_confused: no
filter_rDNA: no
clean: yes

[cluster_consensus]
resources:
tmpDir:
Blastclust_identity: 0
Blastclust_coverage: 80
MCL_inflation: 4.0
MCL_coverage: 0.0
clean: yes" > TEdenovo.cfg
	ln -s /share/banks/ProfilesBankForREPET_Pfam27.0_GypsyDB.hmm
	ln -s /share/banks/repbase20.05_aaSeq_cleaned_TE.fsa
	ln -s /share/banks/repbase20.05_ntSeq_cleaned_TE.fsa
	launch_TEdenovo.py -P project -C TEdenovo.cfg --struct -f MCL -v 3 > launchTEdenovo.txt 
	cd ..
done





