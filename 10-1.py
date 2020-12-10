#!/usr/bin/env python

ratings = [0] + sorted([int(row) for row in open('10.input').readlines()])
ratings += [ratings[-1] + 3]

threes = 0
ones = 0
row = 1

while row < len(ratings):
    if ratings[row] - ratings[row - 1] == 1:
        ones += 1
    elif ratings[row] - ratings[row - 1] == 3:
        threes += 1

    row += 1

print(f"{ones * threes}")
