require 'color'

module CyanGame
  class Color

    PERCENTAGE_RANGE = (0.0 .. 100.0)
    DEGREE_RANGE = (0.0 .. 360.0)

    attr_reader :hsl

    # Creates an HSL color object.  Hue is given in degrees 0..360.
    # Saturation and lightness are percentages 0..100.  The public
    # interface is HSL, but a private RGB instance is also kept
    # to optimize `to_i`.
    def initialize(h, s, l)
      assert_degrees(h)
      assert_percentages(s, l)
      @hsl = ::Color::HSL.new(h, s, l)
      @rgb = @hsl.to_rgb
    end

    def ==(other)
      @hsl == other.hsl
    end
    alias_method :eql?, :==

    # Return position on color wheel, in degrees, where red is 0.
    def hue
      @hsl.hue
    end

    # Returns a 32-bit unsigned RGBA integer.  The first (most significant)
    # byte is alpha, then red, green, and blue. Two bitwise operators
    # are used: left shift and bitwise or. (http://bit.ly/1zWV0N5)
    def to_i
      r, g, b = rgb_bytes
      255 << 24 | r.to_i << 16 | g.to_i << 8 | b.to_i
    end

    private

    def assert_percentages(*args)
      args.each do |a|
        unless PERCENTAGE_RANGE.cover?(a)
          raise TypeError, "Expected percentage, got #{a}"
        end
      end
    end

    def assert_degrees(θ)
      raise TypeError unless DEGREE_RANGE.cover?(θ)
    end

    # Returns array of red, green, blue in the range 0..255.
    def rgb_bytes
      [@rgb.red, @rgb.green, @rgb.blue]
    end

    CYAN =    new(180, 100, 50)
    WHITE =   new(0,   0,   100)
    YELLOW =  new(60,  100, 50)
    MAGENTA = new(300, 100, 50)

  end
end
