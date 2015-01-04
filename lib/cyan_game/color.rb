module CyanGame
  class Color

    attr_reader :r, :g, :b

    def initialize(r, g, b)
      assert_unsigned_8_bit(r, g, b)
      @r, @g, @b = r, g, b
    end

    def ==(other)
      @r == other.r && @g == other.g && @b == other.b
    end
    alias_method :eql?, :==

    def hue
      ColorWheel.rgb_to_hue(@r, @g, @b)
    end

    # Combine four 8-bit unsigned ints into one 32-bit unsigned int.
    # (http://bit.ly/1zWV0N5)  The most significant byte is actually
    # alpha, which is not what you'd expect from the acronym RGBA.
    def to_i
      255 << 24 | @r.to_i << 16 | @g.to_i << 8 | @b.to_i
    end

    private

    def assert_unsigned_8_bit(*args)
      raise TypeError if args.any? { |a| a < 0 || a > 255 }
    end

    CYAN = new(0, 255, 255)
    WHITE = new(255, 255, 255)
    YELLOW = new(255, 255, 0)
    MAGENTA = new(255, 0, 255)

  end
end
