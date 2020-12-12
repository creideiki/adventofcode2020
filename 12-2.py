#!/usr/bin/env python

import re
import sys

instructions = [insn.strip() for insn in open('12.input').readlines()]

instruction_format = re.compile("(?P<inst>N|S|E|W|L|R|F)(?P<oper>[0-9]+)")

class Ship:
    def __init__(self, x, y, dwx, dwy):
        self.x = x
        self.y = y
        self.dwx = dwx
        self.dwy = dwy

    def forward(self, steps):
        self.x += self.dwx * steps
        self.y += self.dwy * steps

    def move(self, x, y):
        self.dwx += x
        self.dwy += y

    def turn(self, direction, angle):
        if direction == 'L':
            angle = -angle % 360

        if angle == 0:
                pass
        elif angle == 90:
            new_dwx = self.dwy
            self.dwy = -self.dwx
            self.dwx = new_dwx
        elif angle == 180:
            self.dwx = -self.dwx
            self.dwy = -self.dwy
        elif angle == 270:
            new_dwy = self.dwx
            self.dwx = -self.dwy
            self.dwy = new_dwy
        else:
            print(f"Illegal angle: {angle}")
            sys.exit()

    def __str__(self):
        return f"<{self.__class__.__name__}: ({self.x}, {self.y}), ({self.dwx}, {self.dwy})>"

ship = Ship(0, 0, 10, 1)

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
