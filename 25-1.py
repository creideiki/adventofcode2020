#!/usr/bin/env python

public_key_card, public_key_door = open('25.input').read().strip().split("\n")
public_key_card = int(public_key_card)
public_key_door = int(public_key_door)

def transform(subject, loop_size):
  return pow(subject, loop_size, 20201227)

loop_size_card = -1
for candidate_card_loop_size in range(1, 20201227):
    if transform(7, candidate_card_loop_size) == public_key_card:
        loop_size_card = candidate_card_loop_size
        break
print(f"Card loop size: {loop_size_card}")

loop_size_door = -1
for candidate_door_loop_size in range(1, 20201227):
    if transform(7, candidate_door_loop_size) == public_key_door:
        loop_size_door = candidate_door_loop_size
        break
print(f"Door loop size: {loop_size_door}")

encryption_key_card = transform(public_key_door, loop_size_card)
encryption_key_door = transform(public_key_card, loop_size_door)

if encryption_key_card != encryption_key_door:
  print("Error establishing encryption key")
  sys.exit()

print(encryption_key_card)
