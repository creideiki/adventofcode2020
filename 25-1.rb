#!/usr/bin/env ruby

public_key_card, public_key_door = File.read('25.input').split.map &:to_i

def transform(subject, loop_size)
  subject.pow(loop_size, 20201227)
end

loop_size_card = -1
1.upto 20201227 do |candidate_card_loop_size|
  if transform(7, candidate_card_loop_size) == public_key_card
    loop_size_card = candidate_card_loop_size
    break
  end
end
print "Card loop size: #{loop_size_card}\n"

loop_size_door = -1
1.upto 20201227 do |candidate_door_loop_size|
  if transform(7, candidate_door_loop_size) == public_key_door
    loop_size_door = candidate_door_loop_size
    break
  end
end
print "Door loop size: #{loop_size_door}\n"

encryption_key_card = transform(public_key_door, loop_size_card)
encryption_key_door = transform(public_key_card, loop_size_door)

if encryption_key_card != encryption_key_door
  print "Error establishing encryption key\n"
end

print encryption_key_card, "\n"
