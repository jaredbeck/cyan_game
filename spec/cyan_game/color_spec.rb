require_relative '../../lib/cyan_game/color'

describe CyanGame::Color do

  def color(r, g, b)
    CyanGame::Color.new(r, g, b)
  end

  let(:red)     { color(255, 000, 000) }
  let(:blue)    { color(000, 000, 255) }
  let(:green)   { color(000, 255, 000) }
  let(:yellow)  { color(255, 255, 000) }
  let(:magenta) { color(255, 000, 255) }
  let(:cyan)    { color(000, 255, 255) }

  describe '.hue' do
    it 'returns position on wheel, in radians' do

      # primary
      expect(red.hue).to be_within(0.01).of(0)
      expect(green.hue).to be_within(0.01).of(2 * Math::PI / 3)
      expect(blue.hue).to be_within(0.01).of(4 * Math::PI / 3)

      # secondary
      expect(yellow.hue).to be_within(0.01).of(Math::PI / 3)
      expect(cyan.hue).to be_within(0.01).of(3 * Math::PI / 3)
      expect(magenta.hue).to be_within(0.01).of(5 * Math::PI / 3)
    end
  end
end
