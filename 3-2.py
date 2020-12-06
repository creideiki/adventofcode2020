#!/usr/bin/env python

trees = [line.strip() for line in open('3.input').readlines()]

problems = [
    { 'h': 1, 'v': 1 },
    { 'h': 3, 'v': 1 },
    { 'h': 5, 'v': 1 },
    { 'h': 7, 'v': 1 },
    { 'h': 1, 'v': 2 },
]

solutions = 1

for p in problems:
    pos_h = 0
    pos_v = 0

    collissions = 0

    while pos_v < len(trees):
        if trees[pos_v][pos_h] == '#':
            collissions += 1
        pos_h += p['h']
        pos_h %= len(trees[0])
        pos_v += p['v']

    solutions *= collissions

print(solutions)
