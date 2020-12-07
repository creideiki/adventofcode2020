#!/usr/bin/env ruby

class Bag
  attr_accessor :colour

  def initialize(colour)
    @colour = colour
    @parents = []
    @children = []
  end

  attr_accessor :parents

  def add_parent(colour)
    @parents.push colour
  end

  attr_accessor :children

  def add_child(colour)
    @children.push colour
  end
end

$bags = {}

def get_bag(colour)
  $bags.fetch(colour) { |c| $bags[c] = Bag.new(c) }
end

File.read('7.input').lines.each do |edge|
  /(?<source>[ a-z]*) bags contain (?<sinks>[, a-z0-9]*)/.match(edge) do |mb|
    b = get_bag(mb['source'])
    $bags[mb['source']] = b
    if mb['sinks'] == 'no other bags'
      b.children = []
    else
      mb['sinks'].split(',') do |c|
        mc = / ?[0-9]* (?<colour>[ a-z]*) bag(s?)/.match(c)
        b.add_child(mc['colour'])
        get_bag(mc['colour']).add_parent mb['source']
      end
    end
  end
end

visited = {}

queue = ['shiny gold']

solutions = -1

until queue.empty?
  c = queue.shift
  next if visited[c]

  visited[c] = true
  $bags[c].parents.each { |p| queue.push p }
  solutions += 1
end

print "#{solutions}\n"
