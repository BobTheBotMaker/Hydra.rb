module Packet
  HEADER_BYTES = [0x73, 0x6E, 0x70]

  class Parser
    attr_reader :packet, :step, :emitter_callback

    def initialize(callback)
      @current_state = ReadStart.new
      @consumed = false
      @packet = Array.new
      @step = 0
      @emitter_callback = callback
    end

    def save(byte)
      @packet << byte
      @consumed = true
    end

    def clear_packet
      @packet.clear
    end

    def reset_step
      @step = 0
    end

    def mark_consumed
      @consumed = true
    end

    def parse(byte)
      @consumed = false
      until @consumed
        @step += 1
        @current_state = @current_state.handle(byte, self)
      end
    end

  end

  class ResetParser
    def handle(byte,context)
      context.clear_packet
      context.reset_step
      return(ReadStart.new)
    end
  end

  class ReadStart
    def handle(byte, context)
      if byte == Packet::HEADER_BYTES[0]
        context.save(byte)
        context.reset_step
        context.mark_consumed
        return (ReadNew.new)
      else
        context.mark_consumed
        return (ResetParser.new)
      end
    end
  end

  class ReadNew
    def handle(byte, context)
      if byte == Packet::HEADER_BYTES[1] && context.step == 1
        context.save(byte)
        context.reset_step
        return (ReadPacket.new)
      else
        return (ResetParser.new)
      end
    end
  end

  class ReadPacket
    def handle(byte, context)
      if byte == Packet::HEADER_BYTES[2] && context.step == 1
        context.save(byte)
        context.reset_step
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
        context.emitter_callback.call(context.packet)
        return(ResetParser.new)
      end
    end
  end

end