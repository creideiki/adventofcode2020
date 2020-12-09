#!/usr/bin/env python

import sys

inputs = [int(row) for row in open('9.input').readlines()]

lookback = 25

target = -1

row = lookback
while row < len(inputs):
    is_sum = False
    for x in range(row - lookback - 1, row):
        if is_sum:
            break

        for y in range(x, row):
            if inputs[x] + inputs[y] == inputs[row]:
                is_sum = True

    if not is_sum:
        target = inputs[row]
        break

    row += 1

start_row = 0
while start_row < len(inputs):
    end_row = start_row + 1
    while end_row < len(inputs):
        if sum(inputs[start_row:end_row]) == target:
            print(f"{max(inputs[start_row:end_row]) + min(inputs[start_row:end_row])}")
            sys.exit()
        end_row += 1
    start_row += 1
