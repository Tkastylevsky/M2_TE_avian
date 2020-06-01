#!/bin/bash

export path_genomes=/beegfs/data/tkastylevsky/data/paleognathe_genomes/
cd ${path_genomes}
mkdir Casuarius_casuarius
rsync --copy-links --recursive --times --verbose rsync://ftp.ncbi.nlm.nih.gov/genomes/genbank/vertebrate_other/Casuarius_casuarius/latest_assembly_versions/GCA_003342895.1_casCas1/GCA_003342895.1_casCas1_genomic.fna.gz /beegfs/data/tkastylevsky/data/paleognathe_genomes/Casuarius_casuarius

mkdir Crypturellus_cinnamomeus
rsync --copy-links --recursive --times --verbose rsync://ftp.ncbi.nlm.nih.gov/genomes/genbank/vertebrate_other/Crypturellus_cinnamomeus/latest_assembly_versions/GCA_003342915.1_cryCin1/GCA_003342915.1_cryCin1_genomic.fna.gz /beegfs/data/tkastylevsky/data/paleognathe_genomes/Crypturellus_cinnamomeus

mkdir Eudromia_elegans
rsync --copy-links --recursive --times --verbose rsync://ftp.ncbi.nlm.nih.gov/genomes/genbank/vertebrate_other/Eudromia_elegans/latest_assembly_versions/GCA_003342815.1_eudEle1/GCA_003342815.1_eudEle1_genomic.fna.gz /beegfs/data/tkastylevsky/data/paleognathe_genomes/Eudromia_elegans

mkdir Rhea_americana
rsync --copy-links --recursive --times --verbose rsync://ftp.ncbi.nlm.nih.gov/genomes/genbank/vertebrate_other/Rhea_americana/latest_assembly_versions/GCA_003343005.1_rheAme1/GCA_003343005.1_rheAme1_genomic.fna.gz /beegfs/data/tkastylevsky/data/paleognathe_genomes/Rhea_americana
mkdir Pterocnemia_pennata
rsync --copy-links --recursive --times --verbose rsync://ftp.ncbi.nlm.nih.gov/genomes/genbank/vertebrate_other/Pterocnemia_pennata/latest_assembly_versions/GCA_003342835.1_rhePen1/GCA_003342835.1_rhePen1_genomic.fna.gz /beegfs/data/tkastylevsky/data/paleognathe_genomes/Pterocnemia_pennata




for i in `ls ${path_genomes}`
do
	cd ${path_genomes}${i}
	gunzip `ls ${path_genomes}${i}`
	for f in *.fna; do mv -n "$f" "${f/.fna/.fa}"; done
	cd ..
done




