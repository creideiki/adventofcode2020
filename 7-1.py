#!/usr/bin/env python

from collections import deque
import re

class Bag:
  def __init__(self, colour):
    self.colour = colour
    self.parents = []
    self.children = []

  def add_parent(self, colour):
    self.parents.append(colour)

  def add_child(self, colour):
    self.children.append(colour)

bags = {}

def get_bag(colour):
    b = bags.get(colour, None)
    if not b:
        b = Bag(colour)
        bags[colour] = b
    return b

for edge in open('7.input').readlines():
    mb = re.search('(?P<source>[ a-z]*) bags contain (?P<sinks>[, a-z0-9]*)', edge)
    b = get_bag(mb['source'])
    bags[mb['source']] = b
    if mb['sinks'] == 'no other bags':
        b.children = []
    else:
        for c in mb['sinks'].split(','):
            mc = re.search(' ?[0-9]* (?P<colour>[ a-z]*) bag(s?)', c)
            b.add_child(mc['colour'])
            get_bag(mc['colour']).add_parent(mb['source'])

visited = set()

queue = deque(['shiny gold'])

solutions = -1

while len(queue) > 0:
    c = queue.popleft()
    if c in visited:
        continue

    visited.add(c)
    for p in bags[c].parents:
        queue.append(p)

    solutions += 1

print(f"{solutions}")
