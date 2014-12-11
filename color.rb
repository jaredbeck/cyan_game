class Color

  attr_reader :r, :g, :b

  def initialize(r, g, b)
    assert_unsigned_8_bit(r, g, b)
    @r, @g, @b = r, g, b
  end

  # `pack` returns a "packed" binary string.  The encoding of the
  # string is set to UTF-8, but this "designation" neither changes
  # nor implies anything about the packed string, and is only done
  # so that the packed string may be easily concatenated with
  # other strings, particularly string literals.
  def pack
    [r, g, b].pack('C*').force_encoding('utf-8')
  end

  private

  def assert_unsigned_8_bit(*args)
    raise TypeError if args.any? { |a| a < 0 || a > 255 }
  end

end
