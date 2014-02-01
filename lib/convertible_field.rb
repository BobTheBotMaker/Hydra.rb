module BitFields
  class ConvertibleField

    def initialize(bits)
      @bits = bits
    end

    def to_s
      return(@bits.join(''))
    end

    def to_number
      ret = 0
      index = @bits.length

     while index < @bits.length do
       if @bits[index]
         ret += index ** 2
       end
     end
    puts "Ret: #{ret}"
    end

  end
end