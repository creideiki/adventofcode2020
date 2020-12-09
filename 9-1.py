#!/usr/bin/env python

inputs = [int(row) for row in open('9.input').readlines()]

lookback = 25

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
        print(f"{inputs[row]}")
        break

    row += 1
