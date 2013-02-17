class String
  def pop
    self.slice!(0)
  end
end

module Skipper
  def self.no_whitespace(&f)
    repeatForever yield, &f
  end

  def self.repeatForever(value, &f)
    return value if value != ' '
    repeatForever yield, &f
  end
end

module ExpressionEnumerator
  def self.for(expression)
    Enumerator.new do |yielder|
      loop do
        yielder << Skipper.no_whitespace { expression.pop }
      end
    end
  end
end

module Calculator
  def self.evaluate(expression)
    enum = ExpressionEnumerator.for expression
    calc *enum.take(3)
  end

  def self.calc(left, oper, right)
    raise ArgumentError unless oper =~ /[+-]/
    left.to_i.send oper, right.to_i
  end
end
