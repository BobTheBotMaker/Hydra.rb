require File.expand_path('lib/bit_field.rb')
require 'minitest/autorun'

describe BitFields::BitField do

  before do
    @data = [1,1,1,0,0,1,0,1]
    @string_data = '11100101'
  end

  it 'should initialize from array' do
    structure = {:f1 => 1, :f2 => 3, :f3 => 4}
    bf = BitFields::BitField.new(structure, @data)

    bf.bit_field.f1.bits.must_equal [1]
    bf.bit_field.f2.bits.must_equal [1,1,0]
    bf.bit_field.f3.bits.must_equal [0,1,0,1]
  end

  it 'should handle edge cases' do
    structure = {:f1 => 3, :f2 => 4, :f3 => 1}
    bf = BitFields::BitField.new(structure, @data)

    bf.bit_field.f1.bits.must_equal [1,1,1]
    bf.bit_field.f3.bits.must_equal [1]
  end

  it 'should initialize from string' do
    structure = {:f1 => 1, :f2 => 3, :f3 => 4}
    bf = BitFields::BitField.from_string(structure, @string_data)

    bf.bit_field.f1.bits.must_equal [1]
    bf.bit_field.f2.bits.must_equal [1,1,0]
    bf.bit_field.f3.bits.must_equal [0,1,0,1]
  end

end