import pathlib as pl
from Bio import SeqIO
import os
import sys

path = sys.argv[1]
path_out = sys.argv[2]




weight = pl.Path(path).stat().st_size

data = SeqIO.parse(path, "fasta")
total_size = 0
for seq_record in data :
    total_size = total_size + len(seq_record)


os.mkdir(path_out+"res_split")
path_out = path_out+"res_split/"


ans = weight/total_size

data = SeqIO.parse(path, "fasta")
data = (seq_record.upper() for seq_record in data)
liste_groups = []
count = 0
sublist = []
for seq_record in data :
    count = count + len(seq_record)*ans
    sublist.append(seq_record)
    if 3*10**8 < count :
        count = 0
        liste_groups.append(sublist)
        sublist = []
liste_groups.append(sublist)

for i in range(len(liste_groups)):
    SeqIO.write(liste_groups[i],path_out + "group_"+str(i)+".fa", "fasta")

