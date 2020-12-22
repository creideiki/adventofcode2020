#!/usr/bin/env ruby

deck1, deck2 = File.read('22.input').split("\n\n").map { |d| d.split "\n" }

deck1.shift
deck2.shift

deck1 = deck1.map &:to_i
deck2 = deck2.map &:to_i

until deck1.empty? or deck2.empty?
  card1 = deck1.shift
  card2 = deck2.shift

  if card1 > card2
    deck1.append card1
    deck1.append card2
  elsif card2 > card1
    deck2.append card2
    deck2.append card1
  else
    print "Draw\n", deck1, "\n", deck2, "\n"
    exit
  end
end

winner = (deck2.empty? ? deck1 : deck2).reverse

score = 0
winner.each_with_index do |card, index|
  score += card * (index + 1)
end

print score, "\n"
