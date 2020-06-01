#importation des librairies

from ete3 import NCBITaxa
import os
from ftplib import FTP

#récupération des espèces d'oiseaux

path = "/beegfs/data/tkastylevsky/data/taxonomic_dump"
os.chdir(path)
ncbi = NCBITaxa()
ncbi.update_taxonomy_database()#cette ligne prend du temps si l'opération doit être effectuée plusieurs fois

path_genomes = '/beegfs/data/tkastylevsky/data/genomes'#ouskon les met

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

ftp_ncbi_refseq = FTP('ftp.ncbi.nlm.nih.gov')#meme chose mais sur refseq
ftp_ncbi_refseq.login()
ftp_ncbi_refseq.cwd('genomes/refseq/vertebrate_other/')
ncbi_refseq_bank = ftp_ncbi_refseq.nlst()

refseq_minus_ensembl = set(ncbi_refseq_bank) - set(ensembl_bank)#on vire les especes refseq présentes sur ensembl (attention le canard est encore en doublon parce qu'il est indiqué en sous-espece sur ensembl). 



ensembl_genomes = set(ensembl_bank).intersection(aves)#espèces d'oiseaux présentes sur ensembl
ensembl_genomes = [w.lower() for w in ensembl_genomes]#on retire la majuscule pour pouvoir rematcher dans l'autre sens. 

refseq_genomes = refseq_minus_ensembl.intersection(aves)#especes d'oiseaux présentes sur Refseq et pas sur ensembl

#on va récupérer les génomes d'oiseaux présents sur ensembl
os.chdir(path_genomes)#on se met dans le dossier ou on veut stocker les genomes
for i in ensembl_genomes:
    os.mkdir(i)#on crée le dossier espece et on va dedans.
    os.chdir(i)
    ftp_ensembl.cwd(i+'/dna/')
    liste = ftp_ensembl.nlst()
    subs = 'dna.toplevel.fa.gz'
    res = list(filter(lambda x: subs in x, liste))[0]#on prend juste le premier element de la liste parce que dans ensembl c'est bien fait dans un dossier il y a un seul fichier qui se termine comme ça. 
    with open(res, 'wb') as f:
    # Define the callback as a closure so it can access the opened 
    # file in local scope
        def callback(data):
            f.write(data)
        ftp_ensembl.retrbinary('RETR '+res, callback)
    ftp_ensembl.cwd('../..')
    os.chdir('..')
    
    
os.chdir(path_genomes)
ftp_refseq = FTP('ftp.ncbi.nlm.nih.gov')
ftp_refseq.login()
ftp_refseq.cwd('genomes/refseq/vertebrate_other/')
for i in refseq_genomes:
    os.mkdir(i)
    os.chdir(i)
    ftp_refseq.cwd(i+'/latest_assembly_versions/')
    liste = ftp_refseq.nlst()
    ftp_refseq.cwd(liste[0])
    liste_2 = ftp_refseq.nlst()
    subs = 'genomic.fna.gz'
    res = list(filter(lambda x: subs in x, liste_2))[1]#ici, on met 1 parce que dans la liste de fichiers, il y a CDS_from_genomics avant dans refseq et c'est bien relou d'ailleur.
    with open(res, 'wb') as f:
    # Define the callback as a closure so it can access the opened 
    # file in local scope
        def callback(data):
            f.write(data)
        ftp_refseq.retrbinary('RETR '+res, callback)
    ftp_refseq.cwd('/genomes/refseq/vertebrate_other/')
    os.chdir('..')