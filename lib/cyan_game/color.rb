require 'color'

module CyanGame
  class Color

    attr_reader :rgb

    def initialize(r, g, b)
      assert_unsigned_8_bit(r, g, b)
      @rgb = ::Color::RGB.new(r, g, b)
    end

    def ==(other)
      @rgb == other.rgb
    end
    alias_method :eql?, :==

    # Return position on color wheel, in radians, where red is 0.
    def hue
      @rgb.to_hsl.hue * Math::PI / 180
    end

    # Returns a 32-bit unsigned integer.  The first (most significant)
    # byte is alpha, then red, green, and blue. Two bitwise operators
    # are used: left shift and bitwise or. (http://bit.ly/1zWV0N5)
    def to_i
      r, g, b = rgb_bytes
      255 << 24 | r.to_i << 16 | g.to_i << 8 | b.to_i
    end

    private

    def assert_unsigned_8_bit(*args)
      raise TypeError if args.any? { |a| a < 0 || a > 255 }
    end

    # Returns array of red, green, blue in the range 0..255.
    # T
    def rgb_bytes
      [@rgb.red, @rgb.green, @rgb.blue]
    end

    CYAN = new(0, 255, 255)
    WHITE = new(255, 255, 255)
    YELLOW = new(255, 255, 0)
    MAGENTA = new(255, 0, 255)

  end
end
