require 'bundler'
Bundler.setup
Bundler.require                 # require 'pi_piper'

class MCP3002 < PiPiper::Spi
  
  CH0 = 0b01101000
  CH1 = 0b01111000
  
  def initialize(chip = PiPiper::Spi::CHIP_SELECT_0)
    PiPiper::Spi.begin(chip) do |spi|
      @spi = spi
      @command = 0b10
    end
  end
  
  def set_single_mode(ch = CH0)
    raw = @spi.write ch, 0
    ((raw[0] << 8) + raw[1]) & 0b001111111111
  end

  def differential
  end
  
  if __FILE__ == $0
    mcp3002 = self.new
    10.times do
      p mcp3002.single CH0
      sleep 1
    end
  end
end


