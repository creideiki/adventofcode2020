#!/usr/bin/env python

from collections import deque
from copy import deepcopy

def print_grid(grid):
    for row in range(len(grid)):
        for col in range(len(grid[0])):
            if grid[row][col]:
                print('B', end='')
            else:
                print('w', end='')
        print()

paths = [deque(line.strip()) for line in open('24.input').readlines()]

dimension = 310
row = [False] * dimension
grid = []
for i in range(dimension // 2):
    grid += [deepcopy(row)]

for path in paths:
    x = dimension // 2
    y = dimension // 4
    while len(path) > 0:
        consume = 1
        if path[0] == 'w':
            x -= 2
        elif path[0] == 'e':
            x += 2
        elif path[0] == 'n':
            y -= 1
            if path[1] == 'w':
                x -= 1
            elif path[1] == 'e':
                x += 1
            consume = 2
        elif path[0] == 's':
            y += 1
            if path[1] == 'w':
                x -= 1
            elif path[1] == 'e':
                x += 1
            consume = 2

        for i in range(consume):
            path.popleft()

    grid[y][x] = not grid[y][x]

def count_neighbours(grid, row, column):
    return \
        (1 if grid[row][column - 2] else 0) + \
        (1 if grid[row][column + 2] else 0) + \
        (1 if grid[row - 1][column - 1] else 0) + \
        (1 if grid[row - 1][column + 1] else 0) + \
        (1 if grid[row + 1][column - 1] else 0) + \
        (1 if grid[row + 1][column + 1] else 0)

def evolve(grid):
    dimension = len(grid) * 2
    new_grid = deepcopy(grid)

    for row in range(1, dimension // 2 - 2):
        for column in range(1, dimension - 2):
            if (row % 2 == 0 and column % 2 == 1) or \
               (row % 2 == 1 and column % 2 == 0):
                continue

            if grid[row][column]:
                c = count_neighbours(grid, row, column)
                if c == 0 or c > 2:
                    new_grid[row][column] = False
                else:
                    new_grid[row][column] = True
            else:
                c = count_neighbours(grid, row, column)
                if c == 2:
                    new_grid[row][column] = True
                else:
                    new_grid[row][column] = False
    return new_grid

def count_black(grid):
    count = 0
    for row in range(len(grid)):
        for col in range(len(grid[0])):
            if grid[row][col]:
                count += 1
    return count

for i in range(100):
    grid = evolve(grid)

print_grid(grid)

print(count_black(grid))
