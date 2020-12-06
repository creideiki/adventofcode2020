#!/usr/bin/env python

class Passport:
  fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

  def __init__(self, str):
    for fv in str.split():
      field, value = fv.split(':')
      setattr(self, field, value)

  def valid(self):
    return all(map(lambda f: f == "cid" or getattr(self, f, None),
                   self.fields))

valid = 0
for s in open('4.input').read().split("\n\n"):
  if Passport(s).valid():
    valid += 1

print(valid)

