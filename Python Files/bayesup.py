#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      dalbrght
#
# Created:     19/04/2013
# Copyright:   (c) dalbrght 2013
# Licence:     <your licence>
#-------------------------------------------------------------------------------

def main():
    pass

if __name__ == '__main__':
    main()


headsnum = 0
tailsnum = 0

print("You walk up to a roulette table ready to place a bet. The sign showing the last ten spins that have landed reads as follows:")
print(" R   B   R   R   R ")
print("23   3  14  19  31 ")
roulette = input("You walk up to a roulette table ready to place a bet. Do you place on red or black? (Enter R for red and B for black.)")
obsindependence = input("Why? (Surveyor enters answer.)")




f = open("test.txt", mode='w')
weight = .75
numheads = 0
numtails = 0
for x in range(50):
    if random.random() < weight:
        f.write("H ")
        numheads += 1
    else:
        f.write("T ")
        numtails += 1
f.close()
print("Flipped " + str(numheads) + " heads and " + str(numtails) + " tails.")

