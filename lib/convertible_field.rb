module BitFields
  class ConvertibleField
    attr_reader :bits

    def initialize(bits)
      @bits = bits
    end

    def to_s
      @bits.join('')
    end

    def to_number
      sum = 0
      reversed = @bits.reverse

      reversed.each_with_index { |bit, index|
        if bit == 1
          sum += 2 ** index
        end
      }
      return sum
    end

  end
end