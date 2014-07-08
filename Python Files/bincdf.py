#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      dalbrght
#
# Created:     24/04/2013
# Copyright:   (c) dalbrght 2013
# Licence:     <your licence>
#-------------------------------------------------------------------------------

def main():
    pass

if __name__ == '__main__':
    main()

import math

def combi(n,r):
    return math.factorial(n)/(math.factorial(n-r)*math.factorial(r))

def binpdf(trials, successes, prob):
    return combi(trials, successes)*pow(prob,successes)*pow(1-prob,trials-successes)

def bincdf(trials,lowval,highval,prob):
    pdfs = []

    for x in range(lowval,highval+1):
        pdfs.append(binpdf(trials,x,prob))

    return sum(pdfs)