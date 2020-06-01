import pandas as pa
import numpy as np
import itertools
import csv
import matplotlib.pyplot as plt
import os
import sys


def bedtools_out_shape(path):
    results = pa.read_csv(path,header = None, sep = '\s+')
    results = results.drop([6,7,9,15,16], axis = 1)
    results.columns = ['chr','A_source','A_repeat_class_family','A_start','A_end','A_perc_div','A_ID','B_source','B_repeat_class_family','B_start','B_end','B_perc_div','B_ID','intersect']
    results_split_A = results.A_repeat_class_family.str.split('/')
    results['A_repeat_class'],results['A_repeat_family'] = results_split_A.str[0],results_split_A.str[1]
    results_split_B = results.B_repeat_class_family.str.split('/')
    results['B_repeat_class'],results['B_repeat_family'] = results_split_B.str[0],results_split_B.str[1]
    results['A_intersect'] = results['intersect']/(results['A_end']-results['A_start'])
    results['B_intersect'] = results['intersect']/(results['B_end']-results['B_start'])
    results = results.drop(['A_repeat_class_family','B_repeat_class_family','intersect'], axis = 1)
    return results



def histograms_intersect_A(res,symbol_A,symbol_B,path_res):
    fig = plt.figure()
    plot = res.A_intersect.plot.hist(bins = 100)
    fig = plot.get_figure()
    fig.savefig(path_res+"/intersect_"+symbol_A+"_on_"+symbol_B+".png")
    plot.set_yscale('log')
    fig = plot.get_figure()
    fig.savefig(path_res+"/intersect_"+symbol_A+"_on_"+symbol_B+"_log.png")

def histograms_intersect_B(res,symbol_A,symbol_B,path_res):
    fig = plt.figure()
    plot = res.B_intersect.plot.hist(bins = 100)
    fig = plot.get_figure()
    fig.savefig(path_res+"/intersect_"+symbol_B+"_on_"+symbol_A+".png")
    plot.set_yscale('log')
    fig = plot.get_figure()
    fig.savefig(path_res+"/intersect_"+symbol_B+"_on_"+symbol_A+"_log.png")

    
def perc_intersect(data_A,data_B,symbol_A,symbol_B,results,results_best,path_res):
    ID_A = pa.DataFrame(list(range(1,len(data_A)+1)))
    ID_B = pa.DataFrame(list(range(1,len(data_B)+1)))
    ID_A.columns = ['ID']
    ID_B.columns = ['ID']

    A_presence = ID_A[ID_A.ID.isin(results['A_ID'])]
    B_presence = ID_B[ID_B.ID.isin(results['B_ID'])]
    A_absence = ID_A[~ID_A.ID.isin(results['A_ID'])]
    B_absence = ID_B[~ID_B.ID.isin(results['B_ID'])]

    A_presence_best = ID_A[ID_A.ID.isin(results_best['A_ID'])]
    B_presence_best = ID_B[ID_B.ID.isin(results_best['B_ID'])]
    A_absence_best = ID_A[~ID_A.ID.isin(results_best['A_ID'])]
    B_absence_best = ID_B[~ID_B.ID.isin(results_best['B_ID'])]
    
    perc_hit_A = len(A_presence)/(len(A_presence)+len(A_absence))
    perc_hit_B = len(B_presence)/(len(B_presence)+len(B_absence))

    perc_hit_A_best = len(A_presence_best)/(len(A_presence_best)+len(A_absence_best))
    perc_hit_B_best = len(B_presence_best)/(len(B_presence_best)+len(B_absence_best))
    f = open(path_res+"/"+symbol_A+"_VS_"+symbol_B+".txt", "w+")
    f.write(' '.join([symbol_A, "presence",str(len(A_presence)), 'VS',symbol_A,"best","presence", str(len(A_presence_best)),"\n"]))
    f.write(' '.join([symbol_B, "presence",str(len(B_presence)), 'VS',symbol_B,"best","presence", str(len(B_presence_best)),"\n"]))
    f.write(' '.join([symbol_A, "absence",str(len(A_absence)), 'VS',symbol_A,"best","absence", str(len(A_absence_best)),"\n"]))
    f.write(' '.join([symbol_B, "absence",str(len(B_absence)), 'VS',symbol_B,"best","absence", str(len(B_absence_best)),"\n"]))
    f.write(' '.join(["perc_hit", symbol_A,str(perc_hit_A), ' VS '," perc_hit", symbol_A,"best", str(perc_hit_A_best),"\n"]))
    f.write(' '.join(["perc_hit", symbol_B,str(perc_hit_B), ' VS '," perc_hit", symbol_B,"best", str(perc_hit_B_best),"\n"]))
    f.close() 

def extract_missing(data_A,data_B,symbol_A, symbol_B,results, path_res):
    A_absent = data_A[~data_A[symbol_A+'_ID'].isin(results['A_ID'])]
    B_absent = data_B[~data_B[symbol_B+'_ID'].isin(results['B_ID'])]
    A_absent.to_csv(path_res+'/'+symbol_A+"_absent_in_"+symbol_B+'.csv', sep = '\t', index = False)
    B_absent.to_csv(path_res+'/'+symbol_B+"_absent_in_"+symbol_A+'.csv', sep = '\t', index = False)
 



path = sys.argv[1]

symbol_A = sys.argv[2]
symbol_B = sys.argv[3]

path_data_A = sys.argv[4]
path_data_B = sys.argv[5]
path_res = sys.argv[6]

    
path_intersect = path + symbol_A +"_"+symbol_B+".txt"
path_intersect_best = path + symbol_A +"_"+symbol_B+"_80.txt"


path_res = path_res+"/"+symbol_A+"VS"+symbol_B


os.mkdir(path_res)
results = bedtools_out_shape(path_intersect)
results_best = bedtools_out_shape(path_intersect_best)

histograms_intersect_A(results,symbol_A,symbol_B,path_res)
histograms_intersect_B(results,symbol_A,symbol_B,path_res)
data_A = pa.read_csv(path_data_A, sep = '\t')
data_B = pa.read_csv(path_data_B, sep = '\t')

perc_intersect(data_A,data_B,symbol_A,symbol_B,results,results_best,path_res)
results.to_csv(path_res+"/"+"data_"+symbol_A +"_"+symbol_B+".csv", header = True, index = False)
extract_missing(data_A,data_B,symbol_A,symbol_B,results,path_res)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
