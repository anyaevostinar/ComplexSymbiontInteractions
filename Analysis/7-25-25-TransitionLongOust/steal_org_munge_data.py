import os.path
import gzip

folder = '../../Data/7-25-25-TransitionLongOust/'

treatment_postfixes = ["VT0","VT0.25", "VT0.5","VT0.75", "VT1"]

partners = ["Host", "Sym"]
tasks = ["NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"]
reps = range(1,31)
header = "uid treatment rep update steal_count donate_count difference diff_per_org\n"

outputFileName = "per_steal_munged_basic.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_postfixes:
    for r in reps:
        fname = folder +"SymInstCount_" + t +"_SEED" + str(r)+ ".data"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')

        countname = folder +"OrganismCounts_" + t + "_SEED" + str(r) +".data"
        orgFile = open(countname, 'r')
        
        index = 0
        counts = []
        for line in orgFile:
            if (line[0] != "u"):
                splitline = line.strip().split(',')
                counts.append(int(splitline[2]))

        for line in curFile:
            if (line[0] != "u"):
                splitline = line.strip().split(',')
                
                diff = int(splitline[2]) - int(splitline[1])
                host_outstring = "{} {} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], splitline[1], splitline[2], str(diff), str((diff/counts[index])))
                outFile.write(host_outstring)
                index += 1

        curFile.close()
outFile.close()
