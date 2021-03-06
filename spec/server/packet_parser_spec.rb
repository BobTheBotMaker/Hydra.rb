require File.expand_path('lib/packet_parser.rb')
require 'minitest/autorun'

describe Packet::Parser do

  before do
    @single_packet = [0x73, 0x00,0x00,0x00,0x73, 0x00, 0x00, 0x6E, 0x00, 0x70, 0x73, 0x73, 0x6E, 0x70, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,0x16, 0x17, 0x18, 0x19, 0x20]
    @two_packets = [0x73, 0x00,0x00,0x00,0x73, 0x00, 0x00, 0x6E, 0x00, 0x70, 0x73, 0x73, 0x6E, 0x70, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,0x16, 0x17, 0x18, 0x19, 0x73, 0x6E, 0x70, 0x19, 0x18, 0x17, 0x16, 0x15, 0x14, 0x13, 0x12, 0x11, 0x10, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00,0x30, 0x31]

    @packet1 = [0x73, 0x6E, 0x70, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,0x16, 0x17, 0x18, 0x19]
    @packet2 = [0x73, 0x6E, 0x70, 0x19, 0x18, 0x17, 0x16, 0x15, 0x14, 0x13, 0x12, 0x11, 0x10, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00]

    @counter = 0

  end

  it 'should parse a packet' do

    def handle_packet(packet)
      result = packet
      result.must_equal @packet1
    end

    parser = Packet::Parser.new(method(:handle_packet))
    @single_packet.each { |item| parser.parse(item) }

  end

  it 'should parse two packets' do

    def handle_packet(packet)
      result = packet
      if @counter == 0
        result.must_equal @packet1
      else
        result.must_equal @packet2
      end
      @counter += 1
    end

    parser = Packet::Parser.new(method(:handle_packet))
    @two_packets.each { |item| parser.parse(item) }

  end
end

