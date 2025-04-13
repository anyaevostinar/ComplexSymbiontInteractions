import os.path
import gzip

folder = '../../Data/4-13-25-EliasTest/'

treatment_postfixes = ["AGE250","AGE500", "AGE750"]
partners = ["Host", "Sym"]
reps = range(10,13)
header = "uid treatment rep update count partner\n"

outputFileName = "munged_basic.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_postfixes:
    for r in reps:
        fname = folder +"OrganismCounts_" + t +"_SEED" + str(r)+ ".data"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')
        for line in curFile:
            if (line[0] != "u"):
                splitline = line.split(',')
                outstring1 = "{} {} {} {} {} {}\n".format(uid, t, r, splitline[0], splitline[1], "Count")
                outFile.write(outstring1)
                outstring2 = "{} {} {} {} {} {}\n".format(uid, t, r, splitline[0], splitline[2][0:-1], "Sym")
                outFile.write(outstring2)


        curFile.close()
outFile.close()
