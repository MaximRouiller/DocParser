#!/usr/bin/env python

import sys

print('Executing Doc Parser...')


def main(argv):
    newFilePath = argv[0]
    modifiedFilePath = argv[1]
    sortFileAlphabetically(newFilePath)
    # sortFileAlphabetically(modifiedFilePath)

def sortFileAlphabetically(filePath):
    file = open(filePath)   
    lines = file.readlines()
    lines.sort()
    file.close()

    file = open(filePath, "w+")
    file.writelines(lines)
    file.close()



if __name__ == "__main__":
    main(sys.argv[1:])
