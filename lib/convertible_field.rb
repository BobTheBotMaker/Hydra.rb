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
      ('%d' % '0B'.concat(bits.join(''))).to_i
    end

  end
end