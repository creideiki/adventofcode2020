#!/usr/bin/env python

answers = 0
for group in open('6.input').read().split("\n\n"):
     num_members = 0
     group_answers = {}
     for person in group.strip().split("\n"):
          num_members += 1
          for c in person.strip():
               group_answers[c] = group_answers.get(c, 0) + 1

     for c, v in group_answers.items():
          if v == num_members:
               answers += 1

print(f"{answers}")
