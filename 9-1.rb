#!/usr/bin/env ruby

inputs = File.read('9.input').lines.map(&:to_i)

lookback = 25

row = lookback
while row < inputs.size
  is_sum = false
  (row - lookback - 1).upto(row - 1) do |x|
    break if is_sum

    x.upto(row - 1) do |y|
      is_sum = true if inputs[x] + inputs[y] == inputs[row]
    end
  end
  unless is_sum
    print "#{inputs[row]}\n"
    return
  end
  row += 1
end
