module Packet
  @@header_bytes = [0x73, 0x6E, 0x70]

  class Parser

    def initialize
      @currentState = ReadStart.new
      @consumed = false
      @packet = Array.new
      @step = 0
    end

    def save(byte)
      @packet << byte
      @consumed = true
    end

    def resetStep
      @step = 0
    end

    def markConsumed
      @consumed = true
    end

    def parse(byte)
      @consumed = false
      until @consumed do
        @step++
        @currentState.handle(byte, self)
      end
    end

  end

  class ResetParser
    def handle(byte,context)
      context.packet.clear
      context.resetStep
      return(ReadStart.new)
    end
  end

  class ReadStart
    def handle(byte, context)
      if byte == Packet::header_bytes[0]
        context.save(byte)
        context.resetStep
        context.markConsumed
        return (ReadNew.new)
      else
        return (ResetParser.new)
      end
    end
  end

  class ReadNew
    def handle(byte, context)
      if byte == Packet::header_bytes[1] && context.step == 1
        context.save(byte)
        context.resetStep
        return (ReadPacket.new)
      else
        return (ResetParser.new)
      end
    end
  end

  class ReadPacket
    def handle(byte, context)
      if byte == Packet::header_bytes[2] && context.step == 1
        context.save(byte)
        context.resetStep
        return (ReadToEnd.new)
      else
        return (ResetParser.new)
      end
    end
  end

  class ReadToEnd
    def handle(byte, context)
      context.save(byte)
      if context.step < 20
        return(ReadToEnd.new)
      else
        context.emitterCallback(context.packet)
        return(ResetParser.new)
      end
    end
  end

end