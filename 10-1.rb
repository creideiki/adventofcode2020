#!/usr/bin/env ruby

ratings = [0] + File.read('10.input').lines.map(&:to_i).sort
ratings += [ratings[-1] + 3]

threes = 0
ones = 0
row = 1

while row < ratings.size
  case ratings[row] - ratings[row - 1]
  when 1
    ones += 1
  when 3
    threes += 1
  end
  row += 1
end

print "#{ones * threes}\n"
