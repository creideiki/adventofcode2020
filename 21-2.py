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

actual_allergens = {}

while len(possible_allergens) > 0:
  definitive = [[allergen, possible_ingredients] for allergen, possible_ingredients in possible_allergens.items() if len(possible_ingredients) == 1]
  for allergen, ingredient in definitive:
    actual_allergens[allergen] = ingredient[0]
    for a, possible_ingredients in possible_allergens.items():
      if ingredient[0] in possible_ingredients:
        ingredients = possible_allergens[a]
        possible_allergens[a] = [i for i in ingredients if i != ingredient[0]]
    del possible_allergens[allergen]

result = ""
for allergen in sorted(actual_allergens.keys()):
  result += actual_allergens[allergen] + ","
print(result.rstrip(","))
