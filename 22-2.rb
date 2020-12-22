#!/usr/bin/env ruby

deck1, deck2 = File.read('22.input').split("\n\n").map { |d| d.split "\n" }

deck1.shift
deck2.shift

deck1 = deck1.map &:to_i
deck2 = deck2.map &:to_i

def game(deck1, deck2)
  previous = {}
  until deck1.empty? or deck2.empty?
    return [deck1 + deck2, []] if previous.include? [deck1, deck2].to_s

    previous[[deck1, deck2].to_s] = true

    card1 = deck1.shift
    card2 = deck2.shift

    if deck1.size >= card1 and deck2.size >= card2
      res1, res2 = game(deck1[0..card1 - 1], deck2[0..card2 - 1])
      if res2.empty?
        deck1.append(card1).append(card2)
      elsif res1.empty?
        deck2.append(card2).append(card1)
      else
        print "Subgame draw\n", res1, "\n", res2, "\n"
        exit
      end
    else
      if card1 > card2
        deck1.append(card1).append(card2)
      elsif card2 > card1
        deck2.append(card2).append(card1)
      else
        print "Draw\n", deck1, "\n", deck2, "\n"
        exit
      end
    end
  end

  [deck1, deck2]
end

deck1, deck2 = game(deck1, deck2)

winner = (deck2.empty? ? deck1 : deck2).reverse

score = 0
winner.each_with_index do |card, index|
  score += card * (index + 1)
end

print score, "\n"
