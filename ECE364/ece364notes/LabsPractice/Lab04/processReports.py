#! /usr/bin/env python3.4

import sys
import os, math
import glob
import pprint



def printSet():
    n = {"Susan", "Michael", "Edward", "Audrey"}
    x=[]
    for i in range(len(n)):
        x.append(n.pop())
    x=sorted(x)
    print (x)
# 2- Given the set: n = {"Susan", "Michael", "Edward", "Audrey"},
# write function, printSet() the prints the names to the console, ordered alphabetically.

def getStateName(abb):
    
    
# 3- You are given the following dictionary of State names and abbreviation:
# d = {"Indiana": "IN", "California": "CA", "Ohio": "OH", "Alabama": "AL", "New York": "NY"}.
# Write a function, getStateName(abb) that would take the two letter abbreviation of the state, and return its full name.

# 4- You are given the following dictionary:
# e = {47906: "IN", 47907: "IN", 10001: "NY", 10025: "NY", 90001: "CA", 90005: "CA", 90009: "CA"}.
# Write a function getZipCodes(state), that uses this dictionary, and the one from the previous question.
# This function should take in the state name, and return a set of all the zip codes available for that state.

def main():
    printSet()
    return 0



if __name__ == "__main__":
    main()
