#!/usr/bin/env python

import re
import sys

instructions = [insn.strip() for insn in open('12.input').readlines()]

instruction_format = re.compile("(?P<inst>N|S|E|W|L|R|F)(?P<oper>[0-9]+)")

class Ship:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.direction = 90

    def forward(self, steps):
        if self.direction == 0:
            self.move(0, steps)
        elif self.direction == 90:
            self.move(steps, 0)
        elif self.direction == 180:
            self.move(0, -steps)
        elif self.direction == 270:
            self.move(-steps, 0)
        else:
            print(f"Illegal direction: {self.direction}")
            sys.exit()

    def move(self, x, y):
        self.x += x
        self.y += y

    def turn(self, direction, angle):
        if direction == 'L':
            angle = -angle
        self.direction = (self.direction + angle) % 360

    def __str__(self):
        return f"<{self.__class__.__name__}: ({self.x}, {self.y}), {self.direction}>"

ship = Ship(0, 0)

for insn in instructions:
    m = instruction_format.match(insn)
    if m['inst'] == 'N':
        ship.move(0, int(m['oper']))
    elif m['inst'] == 'S':
        ship.move(0, -int(m['oper']))
    elif m['inst'] == 'E':
        ship.move(int(m['oper']), 0)
    elif m['inst'] == 'W':
        ship.move(-int(m['oper']), 0)
    elif m['inst'] == 'L':
        ship.turn(m['inst'], int(m['oper']))
    elif m['inst'] == 'R':
        ship.turn(m['inst'], int(m['oper']))
    elif m['inst'] == 'F':
        ship.forward(int(m['oper']))
    else:
      print(f"Illegal instruction: {insn}")
      sys.exit()

print(f"{abs(ship.x) + abs(ship.y)}")
