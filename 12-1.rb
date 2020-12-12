#!/usr/bin/env ruby

instructions = File.read('12.input').lines.map(&:strip)

instruction_format = /(?<inst>N|S|E|W|L|R|F)(?<oper>[[:digit:]]+)/

class Ship
  attr_accessor :direction
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x = x
    @y = y
    @direction = 90
  end

  def forward(steps)
    case @direction
    when 0
      move(0, steps)
    when 90
      move(steps, 0)
    when 180
      move(0, -steps)
    when 270
      move(-steps, 0)
    else
      print "Illegal direction: #{@direction}\n"
      exit
    end
  end

  def move(x, y)
    @x += x
    @y += y
  end

  def turn(direction, angle)
    angle = -angle if direction == 'L'
    @direction = (@direction + angle) % 360
  end

  def to_s
    "<#{self.class}: (#{@x}, #{@y}), #{@direction}>"
  end
end

ship = Ship.new(0, 0)

instructions.each do |insn|
  instruction_format.match(insn) do |m|
    case m['inst']
    when 'N'
      ship.move(0, m['oper'].to_i)
    when 'S'
      ship.move(0, -m['oper'].to_i)
    when 'E'
      ship.move(m['oper'].to_i, 0)
    when 'W'
      ship.move(-m['oper'].to_i, 0)
    when 'L'
      ship.turn(m['inst'], m['oper'].to_i)
    when 'R'
      ship.turn(m['inst'], m['oper'].to_i)
    when 'F'
      ship.forward(m['oper'].to_i)
    else
      print "Illegal instruction: #{insn}\n"
      exit
    end
  end
end

print "#{ship.x.abs + ship.y.abs}\n"
