#!/usr/bin/env python

import re

rule_specifications, messages = open('19.input').read().split("\n\n")

rules = {}

for rule in rule_specifications.split("\n"):
    num, prod = rule.split(':')
    if '"' in prod:
        prods = prod.strip().replace('"', '')
    elif '|' in prod:
        l = [[int(r) for r in p.split()] for p in prod.split('|')]
        prods = {}
        for i in range(len(l)):
            prods[i] = l[i]
    else:
        prods = [ int(p) for p in prod.split()]

    rules[int(num)] = prods

def build_regexp(num):
    if isinstance(num, str):
        prod = num
    elif isinstance(num, int):
        prod = build_regexp(rules[num])
    elif isinstance(num, list):
        prod = "".join([build_regexp(r) for r in num])
    elif isinstance(num, dict):
        prod = '(?:' + "|".join([build_regexp(r) for r in num.values()]) + ')'

    if isinstance(num, int) and isinstance(prod, str):
        rules[num] = prod

    return prod

build_regexp(0)

regexp = re.compile(rules[0])

count = 0
for m in messages.split('\n'):
    if regexp.fullmatch(m):
        count += 1

print(count)
