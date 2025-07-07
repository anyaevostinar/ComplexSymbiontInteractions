import os.path
import gzip

folder = '../../Data/7-3-25-ParasiteInstructionBigSweep/'

treatment_postfixes = ["CPU_TRANSFER_CHANCE0.6AMOUNT4", "CPU_TRANSFER_CHANCE0.6AMOUNT6","CPU_TRANSFER_CHANCE0.7AMOUNT4", "CPU_TRANSFER_CHANCE0.7AMOUNT6","CPU_TRANSFER_CHANCE0.8AMOUNT4", "CPU_TRANSFER_CHANCE0.8AMOUNT6"]
partners = ["Host", "Sym"]
reps = range(1,18)
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]

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
                    sym_outstring = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], task, splitline[task_i+1], "Parasite")
                    outFile.write(sym_outstring)
        curFile.close()
outFile.close()