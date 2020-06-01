library(seqinr)
library(dplyr)

path_in = toString(commandArgs(TRUE)[1])
path_out = toString(commandArgs(TRUE)[2])

print(path_in)
genome = read.fasta(path_in)
df = data.frame(names =getName(genome), start = 0,end = getLength(genome) )
genome_name = gsub(".*/","",path_in)
genome_name= gsub("\\..*","",genome_name)
write.table(df,paste(path_out,genome_name,"_genome.bed",sep=""), sep = "\t",quote = FALSE, col.names = FALSE, row.names = FALSE)

  

