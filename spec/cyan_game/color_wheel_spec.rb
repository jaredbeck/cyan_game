require_relative '../../lib/cyan_game/color_wheel'
require_relative '../../lib/cyan_game/color'

describe CyanGame::ColorWheel do

  def color(r, g, b)
    CyanGame::Color.new(r, g, b)
  end

  describe '.rgb_to_hue' do
    it 'returns position on wheel, in radians' do
      w = described_class

      # primary
      # -------

      expect(w.rgb_to_hue(255, 000, 000)).to be_within(0.01).of(0) # red
      expect(w.rgb_to_hue(000, 255, 000)).to be_within(0.01).of(2 * Math::PI / 3) # green
      expect(w.rgb_to_hue(000, 000, 255)).to be_within(0.01).of(4 * Math::PI / 3) # blue

      # secondary
      # ---------

      expect(w.rgb_to_hue(255, 255, 000)).to be_within(0.01).of(Math::PI / 3) # yellow
      expect(w.rgb_to_hue(000, 255, 255)).to be_within(0.01).of(3 * Math::PI / 3) # cyan
      expect(w.rgb_to_hue(255, 000, 255)).to be_within(0.01).of(5 * Math::PI / 3) # magenta
    end
  end

  describe '.rel' do
    it 'returns approximate relationship between two colors' do
      w = described_class

      red =         color(255, 000, 000)
      blue =        color(000, 000, 255)
      green =       color(000, 255, 000)
      yellow =      color(255, 255, 000)
      magenta =     color(255, 000, 255)
      cyan =        color(000, 255, 255)
      chartreuse =  color(127, 255, 000)
      orange =      color(255, 127, 000)
      rose =        color(255, 000, 127)
      violet =      color(127, 000, 255)
      azure =       color(000, 127, 255)
      spring =      color(000, 255, 127)

      # complementary (roughly speaking)
      expect(w.rel(red, blue)).to eq(:complementary)
      expect(w.rel(red, cyan)).to eq(:complementary)
      expect(w.rel(red, green)).to eq(:complementary)
      expect(w.rel(green, blue)).to eq(:complementary)
      expect(w.rel(green, magenta)).to eq(:complementary)
      expect(w.rel(green, red)).to eq(:complementary)
      expect(w.rel(blue, red)).to eq(:complementary)
      expect(w.rel(blue, yellow)).to eq(:complementary)
      expect(w.rel(blue, green)).to eq(:complementary)

      expect(w.rel(cyan, magenta)).to eq(:complementary)
      expect(w.rel(cyan, red)).to eq(:complementary)
      expect(w.rel(cyan, yellow)).to eq(:complementary)

      # adjacent to primary
      expect(w.rel(green, chartreuse)).to eq(:adjacent)
      expect(w.rel(green, spring)).to eq(:adjacent)
      expect(w.rel(red, orange)).to eq(:adjacent)
      expect(w.rel(red, rose)).to eq(:adjacent)
      expect(w.rel(blue, violet)).to eq(:adjacent)
      expect(w.rel(blue, azure)).to eq(:adjacent)

      # adjacent to secondary
      expect(w.rel(cyan, azure)).to eq(:adjacent)
      expect(w.rel(cyan, spring)).to eq(:adjacent)
      expect(w.rel(yellow, chartreuse)).to eq(:adjacent)
      expect(w.rel(yellow, orange)).to eq(:adjacent)
      expect(w.rel(magenta, rose)).to eq(:adjacent)
      expect(w.rel(magenta, violet)).to eq(:adjacent)
    end
  end

end
