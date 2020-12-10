#!/usr/bin/env ruby

adapters = Hash[File.read('10.input').lines.map(&:to_i).map { |a| [a, true] }]
adapters[0] = true
max_rating = adapters.max.first
adapters[max_rating + 3] = true

ways = Array.new(max_rating + 1, 0)
ways[0] = 1

jolt = 0

while jolt <= max_rating
  if adapters[jolt]
    ways[jolt] +=
      (jolt - 1 < 0 ? 0 : ways[jolt - 1]) +
      (jolt - 2 < 0 ? 0 : ways[jolt - 2]) +
      (jolt - 3 < 0 ? 0 : ways[jolt - 3])
  end
  jolt += 1
end

print "#{ways[max_rating]}\n"
