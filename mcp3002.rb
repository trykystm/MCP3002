require 'bundler'
Bundler.setup
Bundler.require                 # require 'pi_piper'

class MCP3002 < PiPiper::Spi
  
  CE0 = CHIP_SELECT_0
  CE1 = CHIP_SELECT_1
  CH0 = 0b01101000
  CH1 = 0b01111000
  
  def initialize(chip = CE0)
    PiPiper::Spi.begin(chip) do |spi|
      @spi = spi
    end
  end
  
  def single(ch = CH0)
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


