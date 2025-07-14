#a script to run several replicates of several treatments locally
#You should create a directory for your result files and run this script from within that directory
# usage: python3 simple_repeat.py <start_seed> <end_seed>
# Assumes that symbulation executable and SymSettings.cfg already in the folder

import subprocess
import sys

chance = [0.8, 0.9,1]
bonus = [10,20,40]
start_amnt = [10,15,23]

def cmd(command):
    '''This wait causes all executions to run in sieries.                          
    For parralelization, remove .wait() and instead delay the                      
    R script calls unitl all neccesary data is created.'''
    return subprocess.Popen(command, shell=True).wait()

def silent_cmd(command):
    '''This wait causes all executions to run in sieries.                          
    For parralelization, remove .wait() and instead delay the                      
    R script calls unitl all neccesary data is created.'''
    return subprocess.Popen(command, shell=True, stdout=subprocess.PIPE).wait()

start_range = 10
end_range = 20

#collect optional command line arguments
if(len(sys.argv) > 1):
    #first argument is the starting range for seeds
    start_range = int(sys.argv[1])
    if(len(sys.argv) > 2):
        #if the user provides a second argument, use it
        #as the inclusive end of the seed range
        end_range = int(sys.argv[2]) + 1
    else:
        #if the user does not provide a second argument,
        #set the seed range as just the single seed 
        #indicated by the first argument
        end_range = start_range + 1

seeds = range(start_range, end_range)

#Tell the user the inclusive range of seeds
print("Using seeds", start_range, "through", end_range-1)

for a in seeds:
    for b in chance:
        for c in bonus:
            for d in start_amnt:
                command_str = './symbulation_sgp -SEED '+str(a)+ ' -CPU_TRANSFER_CHANCE ' +str(b)+ ' -BONUS_UPDATE_WAIT ' +str(c)+ ' -CPU_TRANSFER_AMOUNT ' +str(d)+ ' -FILE_NAME _CHANCE'+str(b)+'_WAIT'+str(c)+'_AMOUNT'+str(d)
                settings_filename = "Output_CHANCE"+str(b)+'_WAIT'+str(c)+'_AMOUNT'+str(d)+"_SEED"+str(a)+".data"

                print(command_str)
                cmd(command_str+" > "+settings_filename)
