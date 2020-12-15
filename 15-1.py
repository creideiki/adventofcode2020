#!/usr/bin/env python

problems = [line.strip() for line in open('15.input').readlines()]

for problem in problems:
    seen = {}
    numbers = [int(n) for n in problem.split(',')]
    for pos in range(len(numbers)):
        seen[numbers[pos]] = [pos] + seen.get(numbers[pos], [])

    for pos in range(len(numbers), 2020):
        if len(seen[numbers[pos - 1]]) == 1:
            numbers.append(0)
            seen[0] = [pos] + seen.get(0, [])[0:1]
        else:
            age = seen[numbers[pos - 1]][0] - seen[numbers[pos - 1]][1]
            numbers.append(age)
            seen[age] = [pos] + seen.get(age, [])[0:1]

    print(numbers[-1])
