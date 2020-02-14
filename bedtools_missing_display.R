
library(csv)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(ggsci)
library(tidyr)


######################################
#getting the data


path = toString(commandArgs(TRUE)[1])
path_data_A = toString(commandArgs(TRUE)[2])
path_data_B = toString(commandArgs(TRUE)[3])
symbol_A = toString(commandArgs(TRUE)[4])
symbol_B = toString(commandArgs(TRUE)[5])
path = paste(path,symbol_A,"VS",symbol_B,"/", sep = "")

path_missing_A = paste(path,symbol_A,"_absent_in_",symbol_B,".csv", sep = "")
path_missing_B = paste(path,symbol_B,"_absent_in_",symbol_A,".csv", sep = "")


path_res = path
missing_A = read.csv(path_missing_A,header = TRUE, sep = "\t")
missing_B = read.csv(path_missing_B,header = TRUE, sep = "\t")
total_A = read.csv(path_data_A, header = TRUE, sep = "\t")
total_B = read.csv(path_data_B, header = TRUE, sep = "\t")


#######################################
#shaping the data which doesn't match
missing_A = separate(missing_A,col = repeat_class_family,sep = '/',into = c('repeat_class','repeat_family'))
missing_B = separate(missing_B,col = repeat_class_family,sep = '/',into = c('repeat_class','repeat_family'))

missing_A$repeat_class = gsub("?",'',missing_A$repeat_class, fixed = TRUE)
missing_A$repeat_class = gsub('Unspecified','Unknown',missing_A$repeat_class, fixed = TRUE)
missing_A$repeat_class = gsub('snRNA|tRNA|scRNA|rRNA','snRNA/tRNA/scRNA/rRNA',missing_A$repeat_class)

missing_B$repeat_class = gsub("?",'',missing_B$repeat_class, fixed = TRUE)
missing_B$repeat_class = gsub('Unspecified','Unknown',missing_B$repeat_class, fixed = TRUE)
missing_B$repeat_class = gsub('snRNA|tRNA|scRNA|rRNA','snRNA/tRNA/scRNA/rRNA',missing_B$repeat_class)


#######################################
#shaping the total data
total_A = separate(total_A,col = repeat_class_family,sep = '/',into = c('repeat_class','repeat_family'))
total_B = separate(total_B,col = repeat_class_family,sep = '/',into = c('repeat_class','repeat_family'))

total_A$repeat_class = gsub("?",'',total_A$repeat_class, fixed = TRUE)
total_A$repeat_class = gsub('Unspecified','Unknown',total_A$repeat_class, fixed = TRUE)
total_A$repeat_class = gsub('snRNA|tRNA|scRNA|rRNA','snRNA/tRNA/scRNA/rRNA',total_A$repeat_class)

total_B$repeat_class = gsub("?",'',total_B$repeat_class, fixed = TRUE)
total_B$repeat_class = gsub('Unspecified','Unknown',total_B$repeat_class, fixed = TRUE)
total_B$repeat_class = gsub('snRNA|tRNA|scRNA|rRNA','snRNA/tRNA/scRNA/rRNA',total_B$repeat_class)


#######################################
#counting the missing data by class

missing_A_class_count = missing_A %>% count(repeat_class)
missing_B_class_count = missing_B %>% count(repeat_class)
total_A_class_count = total_A %>% count(repeat_class)
total_B_class_count = total_B %>% count(repeat_class)


######################################
#barplots of the missing data by class for A

a = ggplot(missing_A_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_A,'missing.png', sep = ""), height = 5, width =10)

b = ggplot(missing_A_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_y_log10()+
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_A,'missing_log.png', sep = ""), height = 5, width =10)

#barplots of the missing data by class for B

c = ggplot(missing_B_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_B,'missing.png', sep = ""), height = 5, width =10)
  
d = ggplot(missing_B_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  scale_y_log10()+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_B,'missing_log.png', sep = ""), height = 5, width =10)



####################################
# barplot of the total data for A

e = ggplot(total_A_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_A,'total.png', sep = ""), height = 5, width =10)
  
f = ggplot(total_A_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_y_log10()+
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_A,'total_log.png', sep = ""), height = 5, width =10)

#barplot of the total data for B

g = ggplot(total_B_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_B,'total.png', sep = ""), height = 5, width =10)
  

h = ggplot(total_B_class_count, aes(x=repeat_class, fill=repeat_class, y=n)) + 
  geom_bar(stat = "identity") +
  scale_y_log10()+
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_B,'total_log.png', sep = ""), height = 5, width =10)


##############################################
#percent of unmatched data for A and B : 

colnames(total_A_class_count)= c('repeat_class','total')
colnames(total_B_class_count) = c('repeat_class','total')
A_class_count = merge(missing_A_class_count,total_A_class_count, by= 'repeat_class')
B_class_count = merge(missing_B_class_count,total_B_class_count, by= 'repeat_class')



A_class_count=A_class_count %>% mutate(percent=n/total)
B_class_count=B_class_count %>% mutate(percent=n/total)


#plot for A
i = ggplot(A_class_count, aes(x=repeat_class, fill=repeat_class, y=percent)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_A,'percent_unmatched.png', sep = ""), height = 5, width =10)

#plot for B
j = ggplot(B_class_count, aes(x=repeat_class, fill=repeat_class, y=percent)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette="Paired")+
  theme(axis.text.x = element_text(angle = 25, hjust = 1))+
  ggsave(paste(path_res,symbol_B,'percent_unmatched.png', sep = ""), height = 5, width =10)


