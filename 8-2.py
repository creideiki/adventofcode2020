#!/usr/bin/env python

import re
import copy

orig_program = [[inst.strip(), False] for inst in open('8.input').readlines()]

instruction_format = re.compile("(?P<inst>acc|nop|jmp) (?P<oper>[+-][0-9]+)")

for line in range(len(orig_program)):
    program = copy.deepcopy(orig_program)

    if program[line][0][0:3] == 'nop':
        program[line][0] = program[line][0].replace('nop', 'jmp')
    elif program[line][0][0:3] == 'jmp':
        program[line][0] = program[line][0].replace('jmp', 'nop')
    else:
        continue

    ip = 0
    acc = 0

    while True:
        if ip >= len(program):
            print(f"{acc}")
            break

        if program[ip][1]:
            break

        program[ip][1] = True

        m = instruction_format.match(program[ip][0])
        if m['inst'] == 'nop':
            ip += 1
        elif m['inst'] == 'acc':
            acc += int(m['oper'])
            ip += 1
        elif m['inst'] == 'jmp':
            ip += int(m['oper'])
