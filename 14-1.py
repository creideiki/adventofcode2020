#!/usr/bin/env python

import re
from functools import reduce
import operator

program = [insn.strip() for insn in open('14.input').readlines()]

memory = {}
mask = 'X' * 36

instruction_format = re.compile('(?P<inst>mask|mem)(\[(?P<addr>[0-9]+)\])? = (?P<oper>[0-9X]+)')

def apply_mask(value, mask):
    masked = 0
    for exp in range(36):
        if mask[35 - exp] == '0':
            pass
        elif mask[35 - exp] == '1':
            masked += 2**exp
        elif mask[35 - exp] == 'X':
            masked += value & 2**exp
    return masked

for insn in program:
    m = instruction_format.match(insn)
    if m['inst'] == 'mask':
        mask = m['oper']
    elif m['inst'] == 'mem':
        memory[int(m['addr'])] = apply_mask(int(m['oper']), mask)
    else:
      print("Illegal instruction: {insn}")
      sys.exit

print(f"{reduce(operator.add, memory.values())}")
