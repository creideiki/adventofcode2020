#!/usr/bin/env ruby

trees = File.readlines('3.input').map {|x| x.strip.split ''}

problems = [
  { stride_h: 1, stride_v: 1 },
  { stride_h: 3, stride_v: 1 },
  { stride_h: 5, stride_v: 1 },
  { stride_h: 7, stride_v: 1 },
  { stride_h: 1, stride_v: 2 },
]

solutions = 1

problems.each do |p|
  pos_h = 0
  pos_v = 0

  collissions = 0

  while pos_v < trees.size do
    collissions += 1 if trees[pos_v][pos_h] == '#'
    pos_h += p[:stride_h]
    pos_h %= trees[0].size
    pos_v += p[:stride_v]
  end

  solutions *= collissions
end

print("#{solutions}\n")
