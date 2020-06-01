from Bio import SeqIO
import pandas as pa
import os
import sys
import re

path = sys.argv[1]
path_out = sys.argv[2]

record_dict = SeqIO.index(path, "fasta")

names = list(record_dict)
lengths = []
for x in names :
     lengths.append(len(record_dict[x]))
        
df = pa.DataFrame([names, lengths])
df = df.transpose()

name = re.sub(".*/", "", path)
name = re.sub("\\..*", "", name)

df.to_csv(path_out+name+"_genome.bed",sep = "\t",header = False,index = False)