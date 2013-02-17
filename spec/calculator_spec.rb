require_relative '../lib/calculator'

describe 'Stringpop' do
  context 'valid string for popping' do
    it 'returns the first character of the string' do
      "Blah".pop.should == "B"
    end
    it 'strips the first character from the string' do
      blah="Blah"
      blah.pop
      blah.should == "lah"
    end
  end
  context 'invalid string for popping' do
    it 'returns nil for empty string pop' do
      "".pop.should be_nil
    end
  end
end

describe 'function of whitespace skippiness' do
  it 'returns immediately if it receives nil' do
    callCount = 0
    input = lambda { callCount += 1; nil }
    Skipper.no_whitespace(&input).should == nil
    callCount.should == 1
  end

  it 'returns the first non-space result' do
    callCount = 0
    input = lambda do
      callCount += 1
      callCount <= 14 ? " " : "X"
    end
    Skipper.no_whitespace(&input).should == "X"
    callCount.should == 15
  end

  it 'calls it twice if the first return is a space' do
    callCount = 0
    input = lambda do
      callCount += 1;
      callCount == 1 ? " " : "X"
    end
    Skipper.no_whitespace(&input)
    callCount.should == 2
  end
end


describe Calculator do
  context 'with valid input' do
    it 'evaluates an addition integral expression' do
      Calculator.evaluate('2 + 0').should == 2
    end

    it 'evaluates a subtraction integral expression' do
      Calculator.evaluate('3 - 2').should == 1
    end
  end

  context 'with invalid input' do
    it 'raises an invalid input error' do
      lambda { Calculator.evaluate('carrot') }.should raise_error(ArgumentError)
    end
  end
end
