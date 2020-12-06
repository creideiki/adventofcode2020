#!/usr/bin/env python

import re

class Passport:
  fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
  eye_colours = {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}

  def __init__(self, str):
    for fv in str.split():
      field, value = fv.split(':')
      setattr(self, field, value)

  def valid(self):
    return all(map(lambda f: getattr(self, "valid_" + f, None)(),
                   self.fields))

  def valid_byr(self):
    return 1920 <= int(getattr(self, "byr", 0)) <= 2002

  def valid_iyr(self):
    return 2010 <= int(getattr(self, "iyr", 0)) <= 2020

  def valid_eyr(self):
    return 2020 <= int(getattr(self, "eyr", 0)) <= 2030

  def valid_hgt(self):
    if not getattr(self, "hgt", None):
      return False
    if self.hgt[-2:] == 'cm':
      return 150 <= int(self.hgt[0:-2]) <= 193
    elif self.hgt[-2:] == 'in':
      return 59 <= int(self.hgt[0:-2]) <= 76
    return False

  def valid_hcl(self):
    return re.fullmatch('#[0-9A-Fa-f]{6}', getattr(self, "hcl", ""))

  def valid_ecl(self):
    return getattr(self, "ecl", None) in self.eye_colours

  def valid_pid(self):
    return re.fullmatch('[0-9]{9}', getattr(self, "pid", ""))

  def valid_cid(self):
    return True

valid = 0
for s in open('4.input').read().split("\n\n"):
  if Passport(s).valid():
    valid += 1

print(valid)
