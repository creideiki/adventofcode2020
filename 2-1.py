#!/usr/bin/env python

num_valid = 0

f = open('2.input')
for line in f.readlines():
    count, allowed, passwd = line.split(' ')
    min, max = count.split('-')
    min = int(min)
    max = int(max)
    c = allowed[0]
    current_count = 0
    for x in passwd:
        if x == c:
            current_count += 1
    if current_count >= min and current_count <= max:
        num_valid +=1

print(num_valid)
