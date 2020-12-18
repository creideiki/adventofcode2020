#!/usr/bin/env ruby

class Token
  attr_reader :type
  attr_reader :value

  def initialize(repr)
    case repr
    when Integer
      @type = :int
      @value = repr
    when /^[[:digit:]]$/
      @type = :int
      @value = repr.to_i
    when '+'
      @type = :add
    when '*'
      @type = :mul
    when '('
      @type = :open
    when ')'
      @type = :close
    end
  end

  def inspect
    "<#{self.class}: type=#{@type} value=#{@value}>"
  end
end

def tokenize(str)
  str.gsub('(', ' ( ').gsub(')', ' ) ').split(' ').map { |s| Token.new(s) }
end

class Parser
  attr_reader :tokens
  attr_reader :current

  def initialize(tokens)
    @tokens = tokens
  end

  def next_token
    @current = @tokens.shift
  end

  def expect(type)
    @current.type == type
  end

  def parse
    next_token
    parse_expr
  end

  def parse_term
    return 0 unless @current

    if expect :int
      val = @current.value
      next_token
    elsif expect :open
      next_token
      val = parse_expr
      expect :close
      next_token
    else
      exit
    end
    val
  end

  def parse_expr
    return 0 unless @current

    val = parse_term

    if @current.nil? or expect :close
    elsif expect :add
      next_token
      right = parse_term
      val += right
      if @current
        tokens.unshift @current
      end
      @current = Token.new val
      val = parse_expr
    elsif expect :mul
      next_token
      right = parse_expr
      val *= right
    else
      exit
    end
    val
  end
end

problems = File.read('18.input').lines.map(&:strip)

sum = 0

problems.each do |problem|
  print "#{problem} "
  val = Parser.new(tokenize(problem)).parse
  print "= #{val}\n"
  sum += val
end

print sum, "\n"
