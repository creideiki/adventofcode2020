#!/usr/bin/env ruby

answers = 0
File.read('6.input').split("\n\n").each do |group|
  group_answers = {}
  group.lines.each do |person|
    person.strip.each_char do |c|
      group_answers[c] = true
    end
  end
  answers += group_answers.count
end

print("#{answers}\n")
