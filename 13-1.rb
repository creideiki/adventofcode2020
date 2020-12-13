#!/usr/bin/env ruby

input = File.read('13.input').lines.map(&:strip)

earliest_departure = input[0].to_i
buses = []

input[1].split(',') do |bus|
  next if bus == 'x'

  buses.push bus.to_i
end

best_wait = earliest_departure
best_bus = 0

buses.each do |bus|
  potential_wait = bus - (earliest_departure % bus)
  if potential_wait < best_wait
    best_wait = potential_wait
    best_bus = bus
  end
end

print "#{best_wait * best_bus}\n"
