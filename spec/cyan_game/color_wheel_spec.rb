require_relative '../../lib/cyan_game/color_wheel'

describe CyanGame::ColorWheel do
  describe '.rad' do
    it 'returns position on wheel, in radians' do
      w = described_class

      # primaries
      # ---------

      # yellow	  0             0π / 3
      # red	    	1.047197551   1π / 3
      # magenta	  2.094395102   2π / 3
      # blue	    3.141592654   3π / 3
      # cyan	    4.188790205   4π / 3
      # green	    5.235987756   5π / 3

      expect(w.rad(255, 255, 000)).to be_within(0.01).of(0) # yellow
      expect(w.rad(255, 000, 000)).to be_within(0.01).of(1.047) # red
      expect(w.rad(255, 000, 255)).to be_within(0.01).of(2.094) # magenta
      expect(w.rad(000, 000, 255)).to be_within(0.01).of(3.142) # blue
      expect(w.rad(000, 255, 255)).to be_within(0.01).of(4.189) # cyan
      expect(w.rad(000, 255, 000)).to be_within(0.01).of(5.236) # green

      # secondaries
      # -----------

      # chartreuse green  5.759586532    5.5π / 3
      # orange            0.523598776    0.5π / 3
      # rose              1.570796327    1.5π / 3
      # violet            2.617993878    2.5π / 3
      # azure             3.66519143     3.5π / 3
      # spring green      4.712388981    4.5π / 3

      expect(w.rad(127, 255, 000)).to be_within(0.01).of(5.760) # chartreuse green
      expect(w.rad(255, 127, 000)).to be_within(0.01).of(0.523) # orange
      expect(w.rad(255, 000, 127)).to be_within(0.01).of(1.571) # rose
      expect(w.rad(127, 000, 255)).to be_within(0.01).of(2.618) # violet
      expect(w.rad(000, 127, 255)).to be_within(0.01).of(3.665) # azure
      expect(w.rad(000, 255, 127)).to be_within(0.01).of(4.712) # spring green
    end
  end
end
