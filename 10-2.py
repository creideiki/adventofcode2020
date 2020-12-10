#!/usr/bin/env python

adapters = {int(a):True for a in open('10.input').readlines()}
adapters[0] = True
max_rating = max(adapters)
adapters[max_rating + 3] = True

ways = [0] * (max_rating + 1)
ways[0] = 1

jolt = 0

while jolt <= max_rating:
    if adapters.get(jolt):
        ways[jolt] += \
            (ways[jolt - 1] if jolt - 1 >= 0 else 0) + \
            (ways[jolt - 2] if jolt - 2 >= 0 else 0) + \
            (ways[jolt - 3] if jolt - 3 >= 0 else 0)
    jolt += 1

print(f"{ways[max_rating]}")
