#!/usr/bin/env python

import re

field_format = re.compile("(?P<name>[^:]+): (?P<from1>[0-9]+)-(?P<to1>[0-9]+) or (?P<from2>[0-9]+)-(?P<to2>[0-9]+)")

field_spec, my, nearby = open('16.input').read().split("\n\n")

class Field:
    def __init__(self, name, from1, to1, from2, to2):
        self.name = name
        self.from1 = int(from1)
        self.to1 = int(to1)
        self.from2 = int(from2)
        self.to2 = int(to2)

    def is_valid(self, value):
        return self.from1 <= int(value) <= self.to1 or \
            self.from2 <= int(value) <= self.to2

    def __str__(self):
        return f"<{self.__class__.__name__}: name={self.name}, valid={self.from1}-{self.to1} or {self.from2}-{self.to2}>"

fields = {}

for m in [field_format.match(field) for field in field_spec.split("\n")]:
    fields[m['name']] = (Field(m['name'], m['from1'], m['to1'], m['from2'], m['to2']))

valid = []

for ticket in nearby.strip().split("\n")[1:]:
    is_valid = True
    for value in ticket.split(","):
        if not any(map(lambda f: f.is_valid(value), fields.values())):
            is_valid = False
    if is_valid:
        valid.append(list(map(lambda f: int(f),
                              ticket.split(','))))

possible = {}

for n in fields.keys():
    possible[n] = [None] * len(fields)

for field_name, values in possible.items():
    for value_num in range(len(fields)):
        values[value_num] = all(
            map(lambda ticket:
                    fields[field_name].is_valid(ticket[value_num]),
                valid))

actual = {}

while len(possible) > 0:
    name, fields = [(name, fields) for name, fields in possible.items() if sum(fields) == 1][0]
    used_index = fields.index(True)
    actual[name] = used_index
    for fields in possible.values():
        fields[used_index] = False
    del possible[name]

my = list(map(lambda s: int(s),
              my.split("\n")[1].split(',')))

product = 1

for name, index in actual.items():
    if name.startswith('departure'):
        product *= my[index]

print(product)
