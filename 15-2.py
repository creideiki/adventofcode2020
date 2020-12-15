#!/usr/bin/env python

problems = [line.strip() for line in open('15.input').readlines()]

for problem in problems:
    seen = {}
    numbers = [int(n) for n in problem.split(',')]
    for pos in range(len(numbers)):
        seen[numbers[pos]] = [pos] + seen.get(numbers[pos], [])

    last = numbers[-1]
    for pos in range(len(numbers), 30000000):
        if len(seen[last]) == 1:
            last = 0
            seen[0] = [pos] + seen.get(0, [])[0:1]
        else:
            age = seen[last][0] - seen[last][1]
            last = age
            seen[age] = [pos] + seen.get(age, [])[0:1]

    print(last)
