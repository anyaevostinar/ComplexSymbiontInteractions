import os.path
import gzip

folder = '../../Data/7-18-25-TransitioninstVTOn/'

treatment_postfixes = ["VT0.25", "VT0.5","VT0.75"]

partners = ["Host", "Sym"]
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]
reps = range(1,30)
header = "uid treatment rep update steal_count donate_count difference\n"

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

                diff = int(splitline[2]) - int(splitline[1]) 
                host_outstring = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], splitline[1], splitline[2], str(diff))
                outFile.write(host_outstring)
                    
        curFile.close()
outFile.close()
