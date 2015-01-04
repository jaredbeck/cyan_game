require_relative '../../lib/cyan_game/color_wheel'
require_relative '../../lib/cyan_game/color'

describe CyanGame::ColorWheel do

  def color(r, g, b)
    CyanGame::Color.new(r, g, b)
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
      expect(w.rel(red, blue)).to eq(-1)
      expect(w.rel(red, cyan)).to eq(-1)
      expect(w.rel(red, green)).to eq(-1)
      expect(w.rel(green, blue)).to eq(-1)
      expect(w.rel(green, magenta)).to eq(-1)
      expect(w.rel(green, red)).to eq(-1)
      expect(w.rel(blue, red)).to eq(-1)
      expect(w.rel(blue, yellow)).to eq(-1)
      expect(w.rel(blue, green)).to eq(-1)

      expect(w.rel(cyan, magenta)).to eq(-1)
      expect(w.rel(cyan, red)).to eq(-1)
      expect(w.rel(cyan, yellow)).to eq(-1)

      # adjacent to primary
      expect(w.rel(green, chartreuse)).to eq(1)
      expect(w.rel(green, spring)).to eq(1)
      expect(w.rel(red, orange)).to eq(1)
      expect(w.rel(red, rose)).to eq(1)
      expect(w.rel(blue, violet)).to eq(1)
      expect(w.rel(blue, azure)).to eq(1)

      # adjacent to secondary
      expect(w.rel(cyan, azure)).to eq(1)
      expect(w.rel(cyan, spring)).to eq(1)
      expect(w.rel(yellow, chartreuse)).to eq(1)
      expect(w.rel(yellow, orange)).to eq(1)
      expect(w.rel(magenta, rose)).to eq(1)
      expect(w.rel(magenta, violet)).to eq(1)
    end
  end

  describe '.shift_hue' do
    it 'returns new hue' do
      w = described_class
      sixth = described_class::PI_OVER_3
      third = sixth * 2
      expect(w.shift_hue(from: 0, to: third, shift: third)).to eq(third)
      expect(w.shift_hue(from: 0, to: third, shift: sixth)).to eq(sixth)
    end
  end

end
