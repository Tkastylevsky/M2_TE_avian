library(csv)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(ggsci)




path = toString(commandArgs(TRUE)[1])

symbol_A = toString(commandArgs(TRUE)[2])
symbol_B = toString(commandArgs(TRUE)[3])



path = paste(path,symbol_A,"VS",symbol_B,"/", sep = "")
path_data = paste(path,"data_",symbol_A,"_",symbol_B,".csv", sep = "")


path_out_csv_A = paste(path,'best_hits_',symbol_A,'_on_',symbol_B)
path_out_csv_B = paste(path,'best_hits_',symbol_B,'_on_',symbol_A)


rep_intersect = read.csv(path_data, header=TRUE)
rep_intersect$B_repeat_class = gsub("?",'',rep_intersect$B_repeat_class, fixed = TRUE)
rep_intersect$B_repeat_class = gsub('Unspecified','Unknown',rep_intersect$B_repeat_class, fixed = TRUE)
rep_intersect$B_repeat_class = gsub('snRNA|tRNA|scRNA','snRNA/tRNA/scRNA',rep_intersect$B_repeat_class)

rep_intersect$A_repeat_class = gsub("?",'',rep_intersect$A_repeat_class, fixed = TRUE)
rep_intersect$A_repeat_class = gsub('Unspecified','Unknown',rep_intersect$A_repeat_class, fixed = TRUE)
rep_intersect$A_repeat_class = gsub('snRNA|tRNA|scRNA','snRNA/tRNA/scRNA',rep_intersect$A_repeat_class)



best_hits_data_A = rep_intersect %>% group_by(A_ID) %>% top_n(1, A_intersect)
write.csv(best_hits_data_A,path_out_csv_A, row.names = FALSE)

best_hits_data_B = rep_intersect %>% group_by(B_ID) %>% top_n(1, B_intersect)
write.csv(best_hits_data_B,path_out_csv_B, row.names = FALSE)


best_hits_data_class_A_on_B = best_hits_data_A %>% group_by(A_repeat_class) %>% count(B_repeat_class)



ans1 = ggplot(best_hits_data_class_A_on_B, aes(fill=B_repeat_class, y=n, x=A_repeat_class)) + 
  geom_bar(position="stack", stat="identity") +
  scale_y_log10()+
  scale_fill_brewer(palette="Paired") + 
  ggsave(paste(path_out_csv_A,'.png'), height = 5, width =10)


ans2 = ggplot(best_hits_data_class_A_on_B, aes(fill=B_repeat_class, y=n, x=A_repeat_class)) +
  geom_bar(position="fill", stat="identity") +
  scale_fill_brewer(palette="Paired") + 
  ggsave(paste(path_out_csv_A,'_perc.png'), height = 5, width =10)


best_hits_data_class_B_on_A = best_hits_data_B %>% group_by(B_repeat_class) %>% count(A_repeat_class)


ans3 = ggplot(best_hits_data_class_B_on_A, aes(fill=A_repeat_class, y=n, x=B_repeat_class)) + 
  geom_bar(position="stack", stat="identity") +
  scale_y_log10()+
  scale_fill_brewer(palette="Paired") + 
  ggsave(paste(path_out_csv_B,'.png'), height = 5, width =10)

ans4 = ggplot(best_hits_data_class_B_on_A, aes(fill=A_repeat_class, y=n, x=B_repeat_class)) +
  geom_bar(position="fill", stat="identity") +
  scale_fill_brewer(palette="Paired") + 
  ggsave(paste(path_out_csv_B,'_perc.png'), height = 5, width =10)




