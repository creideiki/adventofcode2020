#!/usr/bin/env ruby

class Field
  attr_accessor :field
  attr_accessor :dim

  @field = []
  @dim = 0

  def expand
    1.upto (@max_steps + 1) do
      @field = @field = [[false] * @dim] + @field + [[false] * @dim]
    end
    @field = @field.map do |row|
      row = Array.new(@max_steps + 1, false) +
            row +
            Array.new(@max_steps + 1, false)
    end
    @dim = @field.size
    @field = [@field]
    plane = Array.new @dim
    plane = plane.map { |row| Array.new(@dim, false) }
    1.upto (@dim / 2) do
      @field = [plane.clone.map(&:clone)] + @field + [plane.clone.map(&:clone)]
    end
  end

  def initialize(field)
    @max_steps = 6
    @field = field.map do |row|
      row.map do |cell|
        cell == '#'
      end
    end
    @dim = field.size
  end

  def inspect
    "<#{self.class}: size=#{@field.size}>"
  end

  def pp
    print "Planes: #{@field.size}, rows: #{@field[0].size}, columns: #{@field[0][0].size}, dimension: #{@dim}\n"
    @field.map do |plane|
      plane.map do |row|
        next if row.none?

        row.map do |cell|
          if cell
            print '#'
          else
            print '.'
          end
        end
        print "\n"
      end
      print '-' * (@dim / 2), "\n"
    end
  end

  def neighbours(plane, row, col)
    diff = [-1, 0, 1]
    diff.product(diff).product(diff).map(&:flatten).reject { |c| c == [0, 0, 0] }.map do |coords|
      [plane + coords[0],
       row + coords[1],
       col + coords[2]]
    end
  end

  def evolve
    next_field = @field.clone.map do |plane|
      plane = plane.clone.map(&:clone)
    end
    1.upto (@dim - 2) do |plane|
      1.upto (@dim - 2) do |row|
        1.upto (@dim - 2) do |col|
          num_neighbours = neighbours(plane, row, col).map { |n| @field[n[0]][n[1]][n[2]] }.count { |x| x }
          if @field[plane][row][col]
            if not num_neighbours.between?(2, 3)
              next_field[plane][row][col] = false
            end
          else
            if num_neighbours == 3
              next_field[plane][row][col] = true
            end
          end
        end
      end
    end
    @field = next_field
    true
  end

  def num_active
    @field.map do |plane|
      plane.map do |row|
        row.count { |x| x }
      end.reduce(:+)
    end.reduce(:+)
  end
end

field = Field.new File.read('17.input').lines.map { |l| l.strip.split '' }
field.expand
1.upto 6 do
  field.evolve
end

print field.num_active, "\n"
