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

def count_occupied_neighbours(seats, x, y):
    occupied_neighbours = 0
    for dy in [-1, 0, 1]:
        for dx in [-1, 0, 1]:
            if dy == 0 and dx == 0:
                continue

            h = y
            w = x
            while h < len(seats) - 1 and h >= 1 and \
                  w < len(seats[0]) - 1 and w >= 1:
                h += dy
                w += dx
                if seats[h][w] == '#':
                    occupied_neighbours += 1
                    break
                elif seats[h][w] == 'L':
                    break

    return occupied_neighbours

def print_seats(seats):
    print("---")
    for row in seats:
        for seat in row:
            print(seat, end='')
        print()

changes = True
while changes:
    new_seats = deepcopy(seats)
    changes = False
    for y in range(1, height + 1):
        for x in range(1, width + 1):
            occupied_neighbours = count_occupied_neighbours(seats, x, y)

            if seats[y][x] == 'L' and occupied_neighbours == 0:
                new_seats[y][x] = '#'
                changes = True
            elif seats[y][x] == '#' and occupied_neighbours >= 5:
                new_seats[y][x] = 'L'
                changes = True

    seats = new_seats

print(f"{reduce(operator.add, [row.count('#') for row in seats])}")
