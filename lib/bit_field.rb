require 'ostruct'
require_relative 'convertible_field'

module BitFields
  class BitField
    attr_reader :bit_field

    def initialize(structure, data)
      @bit_field = OpenStruct.new(structure)
      @index = 0

      structure.each_key{ |key|
        field_data = data[@index, structure[key]]
        @bit_field.send("#{key}=".to_sym, ConvertibleField.new(field_data))
        @index += structure[key]
      }
    end

    def self.from_string(structure, data)
      tmp = data.split('').map { |i| i.to_i }
      BitField.new(structure, tmp)
    end
  end
end