#!/usr/bin/env ruby

File.read('15.input').lines.map(&:strip).each do |problem|
  seen = Hash.new([])
  numbers = problem.split(',').map(&:to_i)
  numbers.each_index do |pos|
    seen[numbers[pos]] = [pos] + seen[numbers[pos]]
  end
  numbers.size.upto (30000000 - 1) do |pos|
    if seen[numbers[pos - 1]].size == 1
      numbers.push 0
      seen[0] = [pos] + seen[0][..0]
    else
      age = seen[numbers[pos - 1]][0] - seen[numbers[pos - 1]][1]
      numbers.push age
      seen[age] = [pos] + seen[age][..0]
    end
  end
  print numbers.last, "\n"
end
