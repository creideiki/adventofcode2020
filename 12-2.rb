#!/usr/bin/env ruby

instructions = File.read('12.input').lines.map(&:strip)

instruction_format = /(?<inst>N|S|E|W|L|R|F)(?<oper>[[:digit:]]+)/

class Ship
  attr_accessor :x, :y
  attr_accessor :dwx, :dwy

  def initialize(x, y, dwx, dwy)
    @x = x
    @y = y
    @dwx = dwx
    @dwy = dwy
  end

  def forward(steps)
    @x += @dwx * steps
    @y += @dwy * steps
  end

  def move(x, y)
    @dwx += x
    @dwy += y
  end

  def turn(direction, angle)
    angle = -angle % 360 if direction == 'L'
    case angle
    when 0
    when 90
      new_dwx = @dwy
      @dwy = -@dwx
      @dwx = new_dwx
    when 180
      @dwx = -@dwx
      @dwy = -@dwy
    when 270
      new_dwy = @dwx
      @dwx = -@dwy
      @dwy = new_dwy
    else
      print "Illegal angle: #{angle}\n"
      exit
    end
  end

  def to_s
    "<#{self.class}: (#{@x}, #{@y}), (#{@dwx}, #{@dwy})>"
  end
end

ship = Ship.new(0, 0, 10, 1)

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
