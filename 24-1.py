#!/usr/bin/env python

from collections import deque
from copy import deepcopy

paths = [deque(line.strip()) for line in open('24.input').readlines()]

dimension = 65
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

count = 0
for row in range(len(grid)):
    for col in range(len(grid[0])):
        if grid[row][col]:
            count += 1
print(count)
