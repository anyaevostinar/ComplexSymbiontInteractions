import os.path
import gzip

folder = '../../Data/7-11-TrackedStealInst/'

treatment_postfixes = ["CHANCE0.8_WAIT10_AMOUNT10", "CHANCE0.9_WAIT10_AMOUNT10",
"CHANCE0.8_WAIT20_AMOUNT10", "CHANCE0.9_WAIT20_AMOUNT10","CHANCE0.8_WAIT40_AMOUNT10", "CHANCE0.9_WAIT40_AMOUNT10",
"CHANCE0.8_WAIT10_AMOUNT15", "CHANCE0.9_WAIT10_AMOUNT15",
"CHANCE0.8_WAIT20_AMOUNT15", "CHANCE0.9_WAIT20_AMOUNT15","CHANCE0.8_WAIT40_AMOUNT15", "CHANCE0.9_WAIT40_AMOUNT15",
"CHANCE0.8_WAIT10_AMOUNT23", "CHANCE0.9_WAIT10_AMOUNT23",
"CHANCE0.8_WAIT20_AMOUNT23", "CHANCE0.9_WAIT20_AMOUNT23","CHANCE0.8_WAIT40_AMOUNT23", "CHANCE0.9_WAIT40_AMOUNT23"]
partners = ["Host", "Sym"]
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]
reps = range(1,30)
header = "uid treatment rep update task count partner\n"

outputFileName = "munged_basic.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_postfixes:
    for r in reps:
        fname = folder +"Tasks_" + t +"_SEED" + str(r)+ ".data"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')
        for line in curFile:
            if (line[0] != "u"):
                splitline = line.strip().split(',')
                for task_i in range(1, len(splitline), 2):
                    task = tasks[(task_i-1)//2]
                    host_outstring = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], task, splitline[task_i], "Host")
                    outFile.write(host_outstring)
                    sym_outstring = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], task, splitline[task_i+1], "Mutualist")
                    outFile.write(sym_outstring)
        curFile.close()
outFile.close()