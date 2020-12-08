#!/usr/bin/env ruby

orig_program = File.read('8.input').lines.map { |inst| [inst.strip, false] }

instruction_format = /(?<inst>acc|nop|jmp) (?<oper>[+-][[:digit:]]+)/

0.upto orig_program.size - 1 do |line|
  program = orig_program.clone.map(&:clone)

  if program[line][0][0..2] == 'nop'
    program[line][0] = program[line][0].clone
    program[line][0][0..2] = 'jmp'
  elsif program[line][0][0..2] == 'jmp'
    program[line][0] = program[line][0].clone
    program[line][0][0..2] = 'nop'
  else
    next
  end

  ip = 0
  acc = 0

  loop do
    if ip >= program.size
      print("#{acc}\n")
      break
    end

    if program[ip][1]
      break
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
end
