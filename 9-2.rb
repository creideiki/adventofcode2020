#!/usr/bin/env ruby

inputs = File.read('9.input').lines.map(&:to_i)

lookback = 25

target = -1

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
    target = inputs[row]
    break
  end
  row += 1
end

start_row = 0
while start_row < inputs.size
  end_row = start_row + 1
  while end_row < inputs.size
    break if inputs[start_row..end_row].sum > target

    if inputs[start_row..end_row].sum == target
      print "#{inputs[start_row..end_row].max + inputs[start_row..end_row].min}\n"
      return
    end
    end_row += 1
  end
  start_row += 1
end
