#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      dba
#
# Created:     20/04/2013
# Copyright:   (c) dba 2013
# Licence:     <your licence>
#-------------------------------------------------------------------------------
#!/usr/bin/env python

import random
import math

def main():
    pass

if __name__ == '__main__':
    main()

def flip_series(num_trials, weight):
    count_heads = count_tails = 0
    for x in range(num_trials):
        if random.random() < weight:
            count_heads += 1
        else:
            count_tails += 1
    return dict(count_heads=count_heads, count_tails=count_tails)


def series(num_series, num_trials, weight):
    print('Heads Tails')
    for x in range(num_series):
        print('{count_heads:^5} {count_tails:^5}'.format(**flip_series(num_trials, weight)))

def series_filter(num_series, num_trials, weight):
    runs_count = 0
    success_count = 0
##    print('Heads Tails')
    for x in range(num_series):
        run = flip_series(num_trials, weight)
        runs_count += 1
        if run['count_tails'] <= 5:
            success_count += 1
            print('{count_heads:^5} {count_tails:^5}'.format(**run))
    percent = success_count/runs_count
    print('{success_count} met the criteria out of {runs_count} trials or {percent:%}.'.format(success_count=success_count, runs_count=runs_count, percent=percent))
    return percent
##series(20, 20, .75)

def filtavg(numtoavg):
    pcts = [series_filter(1000, 20, .5) for x in range(numtoavg)]
    return sum(pcts)/float(len(pcts))

##series_filter(10000, 20, .9)

print('{0:%}'.format(filtavg(10)))