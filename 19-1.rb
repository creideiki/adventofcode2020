#!/usr/bin/env ruby

rule_specifications, messages = File.read('19.input').split("\n\n")

$rules = {}

rule_specifications.lines.each do |rule|
  num, prod = rule.split ':'
  prods =
    if prod.include? '"'
      prod.strip.gsub('"', '')
    elsif prod.include? '|'
      h = {}
      prod.split('|').map { |p| p.split.map &:to_i }.each_with_index { |p, i| h[i] = p }
      h
    else
      prod.split.map &:to_i
    end
  $rules[num.to_i] = prods
end

def build_regexp(num)
  prod =
    if num.is_a? String
      num
    elsif num.is_a? Integer
      build_regexp $rules[num]
    elsif num.is_a? Array
      num.map { |r| build_regexp r }.join
    elsif num.is_a? Hash
      '(?:' + num.values.map { |r| build_regexp r }.join('|') + ')'
    end
  if num.is_a? Integer and prod.is_a? String
    $rules[num] = prod
  end
  prod
end

build_regexp 0

re = Regexp.new('^' + $rules[0] + '$')

print messages.lines.map(&:strip).count { |m| re.match? m }, "\n"
