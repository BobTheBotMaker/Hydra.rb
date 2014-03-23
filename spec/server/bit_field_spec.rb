require File.expand_path('lib/bit_field.rb')
require 'minitest/autorun'

describe BitFields::BitField do

  before do
    @data = [1,1,1,0,0,1,0,1]
    @string_data = '11100101'
    @int_array = [115,110,255,254,85,128,0]
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
    bf = BitFields::BitField.from_bit_string(structure, @string_data)

    bf.bit_field.f1.bits.must_equal [1]
    bf.bit_field.f2.bits.must_equal [1,1,0]
    bf.bit_field.f3.bits.must_equal [0,1,0,1]
  end

  it 'should initialize from an integer array' do
    structure = { :f1 => 8, :f2 => 8, :f3 => 8, :f4 => 8, :f5 => 8, :f6 => 8, :f7 => 8 }
    bf = BitFields::BitField.from_int_array(structure, @int_array)

    bf.bit_field.f1.bits.must_equal [0,1,1,1,0,0,1,1]
    bf.bit_field.f3.bits.must_equal [1,1,1,1,1,1,1,1]
    bf.bit_field.f6.bits.must_equal [1,0,0,0,0,0,0,0]

    bf.bit_field.f1.to_number.must_equal 115
    bf.bit_field.f3.to_number.must_equal 255
    bf.bit_field.f4.to_number.must_equal 254
    bf.bit_field.f6.to_number.must_equal 128
  end

end