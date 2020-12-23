#!/usr/bin/env ruby

cups = File.read('23.input').strip.split('').map &:to_i
num_cups = cups.size

current = 0
0.upto 99 do |move|
  current_label = cups[current]
  print "-- Move #{move + 1} --\n"
  print 'Cups: '
  print cups.map { |c| c == current_label ? '(' + c.to_s + ')' : c.to_s }.join '  '
  print "\n"

  removed = cups[current + 1..current + 3]
  if removed.size < 3
    removed += cups[0..3 - removed.size - 1]
  end
  print "Pick up: #{removed.join(', ')}\n"

  cups = cups.difference removed
  destination_label = (current_label - 1) % num_cups
  destination_label = num_cups if destination_label == 0
  while removed.include? destination_label
    print "Destination? #{destination_label}\n"
    destination_label = (destination_label - 1) % num_cups
    destination_label = num_cups if destination_label == 0
  end
  destination_label = num_cups if destination_label == 0
  print "Destination: #{destination_label}\n"
  destination = cups.index destination_label
  cups = cups[0..destination] + removed + cups[destination + 1..]
  print "\n"
  current = (cups.index(current_label) + 1) % num_cups
end

print "-- Final --\n"
print 'Cups: '
print cups.map { |c| c == cups[current] ? '(' + c.to_s + ')' : c.to_s }.join '  '
print "\n"

one = cups.index 1
solution = cups[one + 1..] + cups[0..one - 1]
print "Solution: ", solution.join, "\n"
