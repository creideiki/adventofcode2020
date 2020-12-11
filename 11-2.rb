#!/usr/bin/env ruby

seats = File.read('11.input').lines.map(&:strip)
height = seats.size
width = seats[0].size
seats.unshift('.' * width).push('.' * width)
seats = seats.map { |row| '.' + row + '.' }

def count_occupied_neighbours(seats, x, y)
  occupied_neighbours = 0
  (-1).upto(1) do |dy|
    (-1).upto(1) do |dx|
      next if dy.zero? and dx.zero?

      h = y
      w = x
      while h < seats.size - 1 and h >= 1 and
          w < seats[0].size - 1 and w >= 1
        h += dy
        w += dx
        if seats[h][w] == '#'
          occupied_neighbours += 1
          break
        elsif seats[h][w] == 'L'
          break
        end
      end
    end
  end
  occupied_neighbours
end

def print_seats(seats)
  print "---\n"
  seats.each { |row| print row, "\n" }
end

loop do
  new_seats = seats.clone.map(&:clone)
  changes = false
  1.upto height do |y|
    1.upto width do |x|
      occupied_neighbours = count_occupied_neighbours(seats, x, y)
      if seats[y][x] == 'L' and occupied_neighbours == 0
        new_seats[y][x] = '#'
        changes = true
      elsif seats[y][x] == '#' and occupied_neighbours >= 5
        new_seats[y][x] = 'L'
        changes = true
      end
    end
  end
  seats = new_seats
  break unless changes
end

print seats.map { |row| row.count '#' }.reduce(:+), "\n"
