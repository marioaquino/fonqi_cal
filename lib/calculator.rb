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
    left = enum.next
    op = case enum.next
    when "+"
      proc {|a, b| a + b }
    when "-"
      proc {|a, b| a - b }
    else
      raise ArgumentError
    end
    right = enum.next
    op.call left.to_i, right.to_i
  end
end
