#!/usr/bin/env python

from functools import reduce

specs = [spec.strip() for spec in open('21.input').readlines()]

foods = []
possible_allergens = {}

for spec in specs:
  ingredients, allergens = spec.split('(')
  ingredients = ingredients.split()
  allergens = [a.rstrip(',)') for a in allergens.split() if a != 'contains' ]
  for a in allergens:
    possible_allergens[a] = []
  foods.append([ingredients, allergens])

for allergen in possible_allergens.keys():
  foods_containing_allergen = [f[0] for f in foods if allergen in f[1]]
  possible_allergens[allergen] = reduce(lambda a, b: list(set(a) & set(b)), foods_containing_allergen)

safe = {}

for food in foods:
    ingredients = food[0]
    for ingredient in ingredients:
        if not any(map(lambda i: ingredient in i[1], possible_allergens.items())):
            safe[ingredient] = True

count = 0
for f in foods:
    for ingredient in f[0]:
        if ingredient in safe:
            count += 1

print(count)
