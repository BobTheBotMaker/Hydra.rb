require File.expand_path('lib/convertible_field.rb')
require 'minitest/autorun'

describe BitFields::ConvertibleField do

  before do
    @bit_field = [1,1,1,0,0,1,0,1]
    @cf = BitFields::ConvertibleField.new(@bit_field)
  end

  it 'should store and return an array' do
    @cf.bits.must_equal @bit_field
  end

  it 'should convert to string' do
    result = '11100101'
    as_string = @cf.to_s

    as_string.must_equal result
  end

  it 'should convert to a number' do
    result = 229
    as_number = @cf.to_number
    as_number.must_equal result
  end

end