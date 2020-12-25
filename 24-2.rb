#!/usr/bin/env ruby

def print_grid(grid)
  grid.each do |row|
    row.each do |cell|
      cell ? print('B') : print('w')
    end
    print "\n"
  end
end

paths = File.read('24.input').lines.map { |l| l.strip.split '' }

dimension = 310
grid = Array.new dimension / 2
grid = grid.map { |row| Array.new(dimension, false) }

paths.each do |path|
  column = dimension / 2
  row = dimension / 4
  until path.empty? do
    consume = 1
    case path[0]
    when 'w'
      column -= 2
    when 'e'
      column += 2
    when 'n'
      row -= 1
      case path[1]
      when 'w'
        column -= 1
      when 'e'
        column += 1
      end
      consume = 2
    when 's'
      row += 1
      case path[1]
      when 'w'
        column -= 1
      when 'e'
        column += 1
      end
      consume = 2
    end
    1.upto(consume) { path.shift }
  end
  grid[row][column] = !grid[row][column]
end

def count_neighbours(grid, row, column)
  (grid[row][column - 2] ? 1 : 0) +
  (grid[row][column + 2] ? 1 : 0) +
  (grid[row - 1][column - 1] ? 1 : 0) +
  (grid[row - 1][column + 1] ? 1 : 0) +
  (grid[row + 1][column - 1] ? 1 : 0) +
  (grid[row + 1][column + 1] ? 1 : 0)
end

def evolve(grid)
  dimension = grid.size * 2
  new_grid = Array.new dimension / 2
  new_grid = grid.map { |row| Array.new(dimension, false) }

  1.upto(dimension / 2 - 2) do |row|
    1.upto(dimension - 2) do |column|
      next if (row.even? and column.odd?) or
              (row.odd? and column.even?)

      if grid[row][column]
        c = count_neighbours(grid, row, column)
        if c == 0 or c > 2
          new_grid[row][column] = false
        else
          new_grid[row][column] = true
        end
      else
        c = count_neighbours(grid, row, column)
        if c == 2
          new_grid[row][column] = true
        else
          new_grid[row][column] = false
        end
      end
    end
  end
  new_grid
end

def count_black(grid)
  grid.map { |row| row.count { |c| c } }.reduce :+
end

1.upto 100 do
  grid = evolve(grid)
end

print_grid(grid)

print count_black(grid), "\n"
