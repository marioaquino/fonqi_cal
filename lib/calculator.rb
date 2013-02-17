class String
  def pop
    self.slice!(0)
  end
end

module Skipper
  def self.no_whitespace(f)
    repeatForever &f
  end

  def self.repeatForever
    while true do
      if (result = yield) != ' '
        return result
      end
    end
  end
end

module Calculator
  def self.evaluate(expression)
    firstArg = expression.pop
    expression.pop
    op = case expression.pop
    when "+"
      proc {|a, b| a + b }
    when "-"
      proc {|a, b| a - b }
    else
      raise ArgumentError
    end
    expression.pop
    result = op.call(firstArg.to_i,expression.pop.to_i)
    puts "\n#{expression} = #{result}"
    result
  end
end
