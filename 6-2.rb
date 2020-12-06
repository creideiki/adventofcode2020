#!/usr/bin/env ruby

answers = 0
File.read('6.input').split("\n\n").each do |group|
  num_members = 0
  group_answers = {}
  group.lines.each do |person|
    num_members += 1
    person.strip.each_char do |c|
      group_answers[c] = group_answers[c].to_i + 1
    end
  end
  answers += group_answers.count {|c, v| v == num_members }
end

print("#{answers}\n")
