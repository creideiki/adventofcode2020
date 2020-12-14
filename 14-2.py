#!/usr/bin/env python

import re
from functools import reduce
import operator

program = [line.strip() for line in open('14.input').readlines()]

memory = {}
mask = '0' * 36

instruction_format = re.compile('(?P<inst>mask|mem)(\[(?P<addr>[0-9]+)\])? = (?P<oper>[0-9X]+)')

def apply_mask(address, mask):
    addresses = ['']
    address = bin(int(address))[2:][::-1].ljust(36, '0')
    mask = mask[::-1]
    while address != '':
        if mask[0] == '0':
            addresses = [a + address[0] for a in addresses]
        elif mask[0] == '1':
            addresses = [a + '1' for a in addresses]
        elif mask[0] == 'X':
            addresses = [item for subl in [[a + '0', a + '1'] for a in addresses] for item in subl]
        address = address[1:]
        mask = mask[1:]
    addresses = [ int(a[::-1], 2) for a in addresses ]
    return addresses

for insn in program:
    m = instruction_format.match(insn)
    if m['inst'] == 'mask':
        mask = m['oper']
    elif m['inst'] == 'mem':
        for a in apply_mask(int(m['addr']), mask):
            memory[a] = int(m['oper'])
    else:
        print("Illegal instruction: {insn}")
        sys.exit

print(f"{reduce(operator.add, memory.values())}")
