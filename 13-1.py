#!/usr/bin/env python

input = open('13.input').readlines()

earliest_departure = int(input[0])
buses = []

for bus in input[1].split(','):
    if bus == 'x':
        continue

    buses.append(int(bus))

best_wait = earliest_departure
best_bus = 0

for bus in buses:
    potential_wait = bus - (earliest_departure % bus)
    if potential_wait < best_wait:
        best_wait = potential_wait
        best_bus = bus

print(f"{best_wait * best_bus}")
