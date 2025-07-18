import os.path
import gzip

folder = '../../Data/7-15-25-InstSpread/'

treatment_postfixes = ["AMOUNT15", "AMOUNT25","AMOUNT35","AMOUNT50"]
partners = ["Host", "Sym"]
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]
reps = range(1,15)
header = "uid treatment rep update task count partner\n"

outputFileName = "steal_munged_basic.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_postfixes:
    for r in reps:
        fname = folder +"SymInstCount_" + t +"_SEED" + str(r)+ ".data"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')
        for line in curFile:
            if (line[0] != "u"):
                splitline = line.strip().split(',')
                
                host_outstring = "{} {} {} {} {} {}\n".format(uid, t, r, splitline[0], splitline[1], splitline[2])
                outFile.write(host_outstring)
                    
        curFile.close()
outFile.close()
