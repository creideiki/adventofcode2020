#!/usr/bin/env python

trees = [line.strip() for line in open('3.input').readlines()]

stride_h = 3
stride_v = 1

pos_h = 0
pos_v = 0

collissions = 0

while pos_v < len(trees):
    if trees[pos_v][pos_h] == '#':
        collissions += 1
    pos_h += stride_h
    pos_h %= len(trees[0])
    pos_v += stride_v

print(collissions)
