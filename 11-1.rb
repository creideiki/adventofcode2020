#!/usr/bin/env ruby

seats = File.read('11.input').lines.map(&:strip)
height = seats.size
width = seats[0].size
seats.unshift('.' * width).push('.' * width)
seats = seats.map { |row| '.' + row + '.' }

loop do
  new_seats = seats.clone.map(&:clone)
  changes = false
  1.upto height do |y|
    1.upto width do |x|
      occupied_neighbours = 0
      (y - 1).upto(y + 1) do |h|
        (x - 1).upto(x + 1) do |w|
          next if y == h and x == w
          if seats[h][w] == '#'
            occupied_neighbours += 1
          end
        end
      end
      if seats[y][x] == 'L' and occupied_neighbours == 0
        new_seats[y][x] = '#'
        changes = true
      elsif seats[y][x] == '#' and occupied_neighbours >= 4
        new_seats[y][x] = 'L'
        changes = true
      end
    end
  end
  seats = new_seats
  break unless changes
end

print seats.map { |row| row.count '#' }.reduce(:+), "\n"
