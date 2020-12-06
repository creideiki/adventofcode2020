#!/usr/bin/env python

answers = 0
for group in open('6.sample').read().split("\n\n"):
     group_answers = {}
     for person in group.split("\n"):
          for c in person.strip():
               group_answers[c] = True

     answers += len(group_answers)

print(f"{answers}")
