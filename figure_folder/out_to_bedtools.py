import pandas as pa
import numpy as np
import itertools
import csv
import matplotlib.pyplot as plt
import os
import sys

def out_to_csv(path,symbol,chromosome):
    names_col_data = ['SW_score',"perc_div","perc_del","perc_ins", "query_seq", "pos_query_begin", "pos_query_end", "pos_query_left","strand", "matching_repeat", "repeat_class_family", "pos_in_repeat_begin", "pos_in_repeat_end", "pos_in_repeat_left", "TE_"+symbol+"_ID","star"]
    data = pa.read_csv(path,header = None, skiprows = 2, sep = '\s+', names = names_col_data, dtype = str)
    if chromosome != 'whole':
        data = data[data['query_seq']== chromosome]
    if 'chr' not in data.query_seq[1]:
        data.query_seq = 'chr'+ data.query_seq
    data['strand'] = data['strand'].replace('C','-')
    ID = symbol+"_ID"
    data.insert(1,ID,list(range(1,len(data)+1)))
    data.columns = ['SW_score',ID,"perc_div","perc_del","perc_ins", "query_seq", "pos_query_begin", "pos_query_end", "pos_query_left","strand", "matching_repeat", "repeat_class_family", "pos_in_repeat_begin", "pos_in_repeat_end", "pos_in_repeat_left", "TE_"+symbol+"_ID","star"]
    return data


def csv_to_gff(data,symbol):
    data_intersect = data
    data_intersect = data_intersect.drop(["SW_score","perc_del","perc_ins", "pos_query_left", "pos_in_repeat_begin", "pos_in_repeat_end", "pos_in_repeat_left", "star"], axis = 1 )
    data_intersect.insert(1, "source", "RepeatMasker")
    data_intersect.insert(1, "phase", ".")
    data_intersect = data_intersect[['query_seq','source','repeat_class_family','pos_query_begin','pos_query_end', 'perc_div', 'strand','phase', symbol+'_ID']]
    return data_intersect




path_data = sys.argv[1]
symbol = sys.argv[2]
chromosome = sys.argv[3]
    
    
data = out_to_csv(path_data,symbol,chromosome)
data_intersect = csv_to_gff(data, symbol)

data.to_csv(path_data+"."+symbol+".csv", sep = '\t', header = True, index = False)
data_intersect.to_csv(path_data+"."+symbol+".gff", sep = '\t', header = False, index = False)


















