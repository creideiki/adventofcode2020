#!/usr/bin/env ruby

program = File.read('14.input').lines.map(&:strip)

memory = {}
mask = 'X' * 36

instruction_format = /(?<inst>mask|mem)(\[(?<addr>[[:digit:]]+)\])? = (?<oper>[[:digit:]X]+)/

def apply_mask(value, mask)
  masked = 0
  0.upto 35 do |exp|
    case mask[35 - exp]
    when '0'
    when '1'
      masked += 2**exp
    when 'X'
      masked += value & 2**exp
    end
  end
  masked
end

program.each do |insn|
  instruction_format.match(insn) do |m|
    case m['inst']
    when 'mask'
      mask = m['oper']
    when 'mem'
      memory[m['addr'].to_i] = apply_mask(m['oper'].to_i, mask)
    else
      print "Illegal instruction: #{insn}\n"
      exit
    end
  end
end

print memory.values.reduce(0, :+), "\n"
