import os.path
import gzip

folder = '../../Data/7-15-25-Mutualists500/'

seeds = range(1, 30)
treatments_1 = [0, 1]
header_prefix = "seed,sym_type,"#going to add size but idk

def munge_file(out_file_name, out_file_header, in_file_prefix) :
    out_file = open(out_file_name, 'w')
    out_file.write(out_file_header + "\n")
    for seed in seeds :
        for t1 in treatments_1 :
            ms = str(t1) # sym
            s = str(seed) # seed 
            in_file_name = in_file_prefix + "_MOI" + ms + '.0'+ "_SEED" + s + ".data"
            line_prefix = s + "," + ms + ","
            try :
                in_file = open(folder+in_file_name, 'r')
                print("opened file")
                next(in_file)
                for line in in_file :
                    out_file.write(line_prefix + line)
                in_file.close()
            except :
                print("could not read", in_file_name)

    out_file.close()



header = header_prefix + "update,count,hosted_syms"
munge_file("org_counts.dat", header, "OrganismCounts")

header = header_prefix + "update,host_task_NOT,sym_task_NOT,host_task_NAND,sym_task_NAND,host_task_AND,sym_task_AND,host_task_ORN,sym_task_ORN,host_task_OR,sym_task_OR,host_task_ANDN,sym_task_ANDN,host_task_NOR,sym_task_NOR,host_task_XOR,sym_task_XOR,host_task_EQU,sym_task_EQU"
munge_file("task_counts.dat", header, "Tasks")
