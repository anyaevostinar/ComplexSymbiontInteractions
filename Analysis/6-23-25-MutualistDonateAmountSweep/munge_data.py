import os.path
import gzip

folder = '../../Data/6-23-25-MutualistDonateAmountSweep/'

treatment_postfixes = ["CPU_AMOUNT2", "CPU_AMOUNT5","CPU_AMOUNT10","CPU_AMOUNT20"]
partners = ["Host", "Sym"]
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]
reps = range(1,11)
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