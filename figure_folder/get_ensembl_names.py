#importation des librairies

from ete3 import NCBITaxa
import os
from ftplib import FTP

#récupération des espèces d'oiseaux

path = "/home/tkastylevsky/data/taxonomic_dump"
os.chdir(path)
ncbi = NCBITaxa()

path_genomes = '/home/tkastylevsky/FASTA_files/genomes'#ouskon les met
path_out= '/home/tkastylevsky/results/ensembl_list/'
#on prend les espèces et sous especes du clade aves. 
descendants_subsp = ncbi.get_descendant_taxa('Aves')
taxid2names = ncbi.get_taxid_translator(descendants_subsp)
aves_subsp = [*taxid2names.values()]
aves_subsp = [w.replace(' ', '_') for w in aves_subsp]

descendants = ncbi.get_descendant_taxa('Aves',collapse_subspecies=True)
taxid2names_2 = ncbi.get_taxid_translator(descendants)
aves = [*taxid2names_2.values()]
aves = [w.replace(' ', '_') for w in aves]

#on groupe espece et sous-espece
aves = set(aves_subsp).union(set(aves))


#on va dans le ftp d'ensemble et on récupère la liste des especes présentes
ftp_ensembl = FTP('ftp.ensembl.org')
ftp_ensembl.login()
ftp_ensembl.cwd('pub/release-99/fasta/')
ensembl_bank = ftp_ensembl.nlst()
ensembl_bank = [name.capitalize() for name in ensembl_bank]#faut rajouter une majuscule au début des noms d'espece pour les faire matcher avec la liste des especes d'oiseaux. 

ensembl_genomes = set(ensembl_bank).intersection(aves)#espèces d'oiseaux présentes sur ensembl
ensembl_genomes = [w.lower() for w in ensembl_genomes]

file_out = list(ensembl_genomes)

with open(path_out + 'ensembl_genomes.txt', 'w') as f:
    for item in file_out:
        f.write("%s\n" % item)