require_relative '../../lib/cyan_game/color'

describe CyanGame::Color do

  def color(r, g, b)
    CyanGame::Color.new(r, g, b)
  end

  let(:red)     { color(0,   100, 50) }
  let(:yellow)  { color(60,  100, 50) }
  let(:green)   { color(120, 100, 50) }
  let(:cyan)    { color(180, 100, 50) }
  let(:blue)    { color(240, 100, 50) }
  let(:magenta) { color(300, 100, 50) }

  describe '.to_i' do
    it 'returns 32-bit unsigned RGBA integer' do
      expect(red.to_i).to eq(0xffff0000)
      expect(green.to_i).to eq(0xff00ff00)
      expect(blue.to_i).to eq(0xff0000ff)
    end
  end
end
