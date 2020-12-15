#!/usr/bin/env ruby

File.read('15.input').lines.map(&:strip).each do |problem|
  seen = Hash.new([])
  numbers = problem.split(',').map(&:to_i)
  numbers.each_index do |pos|
    seen[numbers[pos]] = [pos] + seen[numbers[pos]]
  end
  last = numbers[-1]
  numbers.size.upto (30000000 - 1) do |pos|
    if seen[last].size == 1
      last = 0
      seen[0] = [pos] + seen[0][..0]
    else
      age = seen[last][0] - seen[last][1]
      last = age
      seen[age] = [pos] + seen[age][..0]
    end
  end
  print last, "\n"
end
