#!/usr/bin/env ruby

program = File.read('8.input').lines.map { |inst| [inst.strip, false] }

ip = 0
acc = 0

instruction_format = /(?<inst>acc|nop|jmp) (?<oper>[+-][[:digit:]]+)/

loop do
  if program[ip][1]
    print("#{acc}\n")
    return
  end

  program[ip][1] = true

  instruction_format.match(program[ip][0]) do |m|
    case m['inst']
    when 'nop'
      ip += 1
    when 'acc'
      acc += m['oper'].to_i
      ip += 1
    when 'jmp'
      ip += m['oper'].to_i
    end
  end
end
