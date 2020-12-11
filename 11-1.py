#!/usr/bin/env python

from copy import deepcopy
from collections import deque
from functools import reduce
import operator

seats = deque([list(line.strip()) for line in open('11.input').readlines()])
height = len(seats)
width = len(seats[0])
seats.appendleft(['.'] * width)
seats.append(['.'] * width)
seats = [ ['.'] + row + ['.'] for row in seats ]

changes = True
while changes:
    new_seats = deepcopy(seats)
    changes = False
    for y in range(1, height + 1):
        for x in range(1, width + 1):
            occupied_neighbours = 0
            for h in range(y - 1, y + 2):
                for w in range(x - 1, x + 2):
                    if y == h and x == w:
                        continue
                    if seats[h][w] == '#':
                        occupied_neighbours += 1

            if seats[y][x] == 'L' and occupied_neighbours == 0:
                new_seats[y][x] = '#'
                changes = True
            elif seats[y][x] == '#' and occupied_neighbours >= 4:
                new_seats[y][x] = 'L'
                changes = True

    seats = new_seats

print(f"{reduce(operator.add, [row.count('#') for row in seats])}")
