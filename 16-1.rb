#!/usr/bin/env ruby

field_format = /(?<name>[^:]+): (?<from1>[[:digit:]]+)-(?<to1>[[:digit:]]+) or (?<from2>[[:digit:]]+)-(?<to2>[[:digit:]]+)/

field_spec, my, nearby = File.read('16.input').split("\n\n")

class Field
  def initialize(name, from1, to1, from2, to2)
    @name = name
    @from1 = from1.to_i
    @to1 = to1.to_i
    @from2 = from2.to_i
    @to2 = to2.to_i
  end

  def valid?(value)
    value.to_i.between?(@from1, @to1) or
      value.to_i.between?(@from2, @to2)
  end

  def inspect
    "<#{self.class}: name=#{@name}, valid=#{@from1}-#{@to1} or #{@from2}-#{@to2}>"
  end

  def to_s
    "#{@name}: #{@from1}-#{@to1} or #{@from2}-#{@to2}"
  end
end

fields = []

field_spec.split("\n").map { |field| field_format.match field }.each do |m|
  fields.push Field.new m['name'], m['from1'], m['to1'], m['from2'], m['to2']
end

errors = 0

nearby.split("\n")[1..].each do |ticket|
  ticket.split(',').each do |value|
    unless fields.any? { |f| f.valid? value }
      errors += value.to_i
    end
  end
end

print errors, "\n"
