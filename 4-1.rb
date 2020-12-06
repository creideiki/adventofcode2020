#!/usr/bin/env ruby

require 'set'

class Passport
  @@fields = [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]
  @@fields.each do |field|
    attr_accessor field
  end

  def initialize(str)
    str.split.each do |fv|
      field, value = fv.split(':')
      self.send(field + "=", value)
    end
  end

  def valid?
    @@fields.all? {|f| f == :cid or self.send f}
  end
end

valid = 0
File.read('4.input').split("\n\n").each do |s|
  valid += 1 if Passport.new(s).valid?
end

print("#{valid}\n")
