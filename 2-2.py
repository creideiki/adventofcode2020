#!/usr/bin/env python

num_valid = 0

f = open('2.input')
for line in f.readlines():
    count, allowed, passwd = line.split(' ')
    pos1, pos2 = count.split('-')
    pos1 = int(pos1) - 1
    pos2 = int(pos2) - 1
    c = allowed[0]
    if (passwd[pos1] == c or passwd[pos2] == c) and not (passwd[pos1] == c and passwd[pos2] == c):
        num_valid +=1

print(num_valid)
