#!/usr/bin/env ruby

require 'set'

class Passport
  @@fields = [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]
  @@fields.each do |field|
    attr_accessor field
  end

  @@eye_colours = Set["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def initialize(str)
    str.split.each do |fv|
      field, value = fv.split(':')
      self.send(field + "=", value)
    end
  end

  def valid_byr?
    @byr.to_i.between?(1920, 2002)
  end

  def valid_iyr?
    @iyr.to_i.between?(2010, 2020)
  end

  def valid_eyr?
    @eyr.to_i.between?(2020, 2030)
  end

  def valid_hgt?
    return false unless @hgt
    case @hgt[-2 .. -1]
    when 'cm'
      return @hgt[0..-3].to_i.between?(150, 193)
    when 'in'
      return @hgt[0..-3].to_i.between?(59, 76)
    end
    false
  end

  def valid_hcl?
    @hcl =~ /#[[:xdigit:]]{6}/
  end

  def valid_ecl?
    @@eye_colours.member? @ecl
  end

  def valid_pid?
    @pid =~ /^[[:digit:]]{9}$/
  end

  def valid_cid?
    true
  end

  def valid?
    @@fields.all? {|f| self.send ('valid_' + f.to_s + '?').to_sym}
  end
end

valid = 0
File.read('4.input').split("\n\n").each do |s|
  valid += 1 if Passport.new(s).valid?
end

print("#{valid}\n")
