#!/usr/bin/env ruby

trees = File.readlines('3.input').map {|x| x.strip.split ''}

stride_h = 3
stride_v = 1

pos_h = 0
pos_v = 0

collissions = 0

while pos_v < trees.size do
  collissions += 1 if trees[pos_v][pos_h] == '#'
  pos_h += stride_h
  pos_h %= trees[0].size
  pos_v += stride_v
end

print("#{collissions}\n")
