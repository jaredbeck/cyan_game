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

      # `pack` returns a "packed" binary string.  The encoding of the
    # string is set to UTF-8, but this "designation" neither changes
    # nor implies anything about the packed string, and is only done
    # so that the packed string may be easily concatenated with
    # other strings, particularly string literals.
    def pack
      [@r, @g, @b].pack('C*').force_encoding('utf-8')
    end

    def rad
      ColorWheel.rad(@r, @g, @b)
    end

    # Combine four 8-bit unsigned ints into one 32-bit unsigned int.
    # (http://bit.ly/1zWV0N5)  The most significant byte is actually
    # alpha, which is not what you'd expect from the acronym RGBA.
    def to_i
      255 << 24 | @r << 16 | @g << 8 | @b
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
