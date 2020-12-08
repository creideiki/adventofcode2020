#!/usr/bin/env python

import re

program = [[inst.strip(), False] for inst in open('8.input').readlines()]

ip = 0
acc = 0

instruction_format = re.compile("(?P<inst>acc|nop|jmp) (?P<oper>[+-][0-9]+)")

while True:
  if program[ip][1]:
    print(f"{acc}")
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
