#!/usr/bin/env ruby

class Token
  attr_reader :type
  attr_reader :value

  def initialize(repr)
    case repr
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
    @tokens.reverse!
    next_token
    parse_expr
  end

  def parse_expr
    return 0 unless @current

    if expect :int
      val = @current.value
      next_token
    elsif expect :close
      next_token
      val = parse_expr
      expect :open
      next_token
    else
      print "Parse error\n"
      exit
    end

    if @current.nil? or expect :open
    elsif expect :add
      next_token
      val += parse_expr
    elsif expect :mul
      next_token
      val *= parse_expr
    else
      print "Parse error\n"
      exit
    end
    val
  end
end

problems = File.read('18.input').lines.map(&:strip)

sum = 0

problems.each do |problem|
  val = Parser.new(tokenize(problem)).parse
  print "#{problem} = #{val}\n"
  sum += val
end

print sum, "\n"
