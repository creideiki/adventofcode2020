#!/usr/bin/env ruby

field_format = /(?<name>[^:]+): (?<from1>[[:digit:]]+)-(?<to1>[[:digit:]]+) or (?<from2>[[:digit:]]+)-(?<to2>[[:digit:]]+)/

field_spec, my, nearby = File.read('16.input').split("\n\n")

class Field
  attr_accessor :name

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

fields = {}

field_spec.split("\n").map { |field| field_format.match field }.each do |m|
  fields[m['name']] = Field.new m['name'], m['from1'], m['to1'], m['from2'], m['to2']
end

valid = []

nearby.split("\n")[1..].each do |ticket|
  is_valid = true
  ticket.split(',').each do |value|
    if fields.none? { |_, f| f.valid? value }
      is_valid = false
    end
  end
  valid.push ticket.split(',').map(&:to_i) if is_valid
end

possible = {}

fields.each_value { |f| possible[f.name] = Array.new(fields.size) }
possible.each do |field_name, values|
  0.upto fields.size - 1 do |value_num|
    values[value_num] = valid.all? { |ticket| fields[field_name].valid? ticket[value_num] }
  end
end

actual = {}

until possible.empty?
  name, fields = possible.find do |name, fields|
    fields.map { |x| x ? 1 : 0 }.reduce(&:+) == 1
  end
  used_index = fields.find_index { |x| x }
  actual[name] = used_index
  possible.each do |_, fields|
    fields[used_index] = false
  end
  possible.delete name
end

my = my.split("\n")[1].split(',').map(&:to_i)

product = 1

actual.select { |name, _| name.start_with? 'departure' }.values.each do |index|
  product *= my[index]
end

print product, "\n"
