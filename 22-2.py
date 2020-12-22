#!/usr/bin/env python

deck1, deck2 = open('22.input').read().split("\n\n")

deck1 = deck1.strip().split("\n")
deck2 = deck2.strip().split("\n")

deck1 = deck1[1:]
deck2 = deck2[1:]

deck1 = list(map(lambda card: int(card), deck1))
deck2 = list(map(lambda card: int(card), deck2))

def game(deck1, deck2):
  previous = set()

  while len(deck1) > 0 and len(deck2) > 0:
    if str([deck1, deck2]) in previous:
      return [deck1 + deck2, []]

    previous.add(str([deck1, deck2]))

    card1 = deck1[0]
    deck1 = deck1[1:]
    card2 = deck2[0]
    deck2 = deck2[1:]

    if len(deck1) >= card1 and len(deck2) >= card2:
      res1, res2 = game(deck1[0:card1], deck2[0:card2])
      if len(res2) == 0:
        deck1.append(card1)
        deck1.append(card2)
      elif len(res1) == 0:
        deck2.append(card2)
        deck2.append(card1)
      else:
        print(f"Subgame draw\n{res1}\n{res2}")
        sys.exit()
    else:
      if card1 > card2:
        deck1.append(card1)
        deck1.append(card2)
      elif card2 > card1:
        deck2.append(card2)
        deck2.append(card1)
      else:
        print(f"Draw\n{deck1}\n{deck2}")
        sys.exit()

  return [deck1, deck2]

deck1, deck2 = game(deck1, deck2)

if len(deck1) == 0:
    winner = deck2[::-1]
else:
    winner = deck1[::-1]

score = 0
for index in range(len(winner)):
  score += winner[index] * (index + 1)

print(score)
