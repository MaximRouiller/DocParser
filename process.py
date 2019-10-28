#!/usr/bin/env python

import sys
import subprocess


print('Executing Doc Parser...')


def main(argv):
    newFilePath = argv[0]
    #modifiedFilePath = argv[1]
    gitRepository = argv[2]
    processNewFilesFromDocs(newFilePath, gitRepository)
    # sortFileAlphabetically(modifiedFilePath)

def processNewFilesFromDocs(filePath, gitRepository):
    sortFileAlphabetically(filePath)
    newFile = open(filePath)
    lines = newFile.readlines()

    for line in lines:
        content=subprocess.check_output(['git', 'show', 'master:'+line.rstrip()], cwd=gitRepository)
        
    newFile.close()

def sortFileAlphabetically(filePath):
    file = open(filePath)   
    lines = file.readlines()
    lines.sort()
    file.close()

    file = open(filePath, "w+")
    file.writelines(lines)
    file.close()
    print('Doc Parser executed.')



if __name__ == "__main__":
    main(sys.argv[1:])
