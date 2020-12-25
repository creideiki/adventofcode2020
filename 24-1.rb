#!/usr/bin/env ruby

paths = File.read('24.input').lines.map { |l| l.strip.split '' }

dimension = 65
grid = Array.new dimension / 2
grid = grid.map { |row| Array.new(dimension, false) }

paths.each do |path|
  x = dimension / 2
  y = dimension / 4
  until path.empty? do
    consume = 1
    case path[0]
    when 'w'
      x -= 2
    when 'e'
      x += 2
    when 'n'
      y -= 1
      case path[1]
      when 'w'
        x -= 1
      when 'e'
        x += 1
      end
      consume = 2
    when 's'
      y += 1
      case path[1]
      when 'w'
        x -= 1
      when 'e'
        x += 1
      end
      consume = 2
    end
    1.upto(consume) { path.shift }
  end
  grid[y][x] = !grid[y][x]
end

print grid.map { |row| row.count { |c| c } }.reduce :+
print "\n"
