#!/usr/bin/env python

from collections import deque

deck1, deck2 = open('22.input').read().split("\n\n")

deck1 = deque(deck1.strip().split("\n"))
deck2 = deque(deck2.strip().split("\n"))

deck1.popleft()
deck2.popleft()

deck1 = deque(map(lambda card: int(card), deck1))
deck2 = deque(map(lambda card: int(card), deck2))

while len(deck1) > 0 and len(deck2) > 0:
  card1 = deck1.popleft()
  card2 = deck2.popleft()

  if card1 > card2:
    deck1.append(card1)
    deck1.append(card2)
  elif card2 > card1:
    deck2.append(card2)
    deck2.append(card1)
  else:
    print(f"Draw\n{deck1}\n{deck2}")
    sys.exit()

if len(deck1) == 0:
    winner = list(deck2)[::-1]
else:
    winner = list(deck1)[::-1]

score = 0
for index in range(len(winner)):
  score += winner[index] * (index + 1)

print(score)
