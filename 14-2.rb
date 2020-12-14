#!/usr/bin/env ruby

program = File.read('14.input').lines.map(&:strip)

memory = {}
mask = '0' * 36

instruction_format = /(?<inst>mask|mem)(\[(?<addr>[[:digit:]]+)\])? = (?<oper>[[:digit:]X]+)/

def apply_mask(address, mask)
  addresses = ['']
  address = address.to_i.to_s(2).reverse.ljust(36, '0')
  mask = mask.reverse
  until address.empty?
    case mask[0]
    when '0'
      addresses.each { |a| a << address[0] }
    when '1'
      addresses.each { |a| a << '1' }
    when 'X'
      addresses = addresses.map { |a| [a + '0', a + '1'] }.flatten
    end
    address = address[1..]
    mask = mask[1..]
  end
  addresses.map { |a| a.reverse.to_i(2) }
end

program.each do |insn|
  instruction_format.match(insn) do |m|
    case m['inst']
    when 'mask'
      mask = m['oper']
    when 'mem'
      apply_mask(m['addr'], mask).each { |a| memory[a] = m['oper'].to_i }
    else
      print "Illegal instruction: #{insn}\n"
      exit
    end
  end
end

print memory.values.reduce(0, :+), "\n"
