require 'color'

module CyanGame
  module ColorWheel

    # If healing is greater than damage, the game is easier.
    # Does that make it more fun?
    DAMAGE  = -1
    HEALING = +1.1

    # A sixth of a circle is π / 3 radians
    PI_OVER_3 = Math::PI / 3.0
    PI_OVER_2 = Math::PI / 2.0

    # Complementary colors are 2π / 3 radians apart
    COMPLEMENT = 2 * PI_OVER_3

    class << self

      # `shift_hue` takes two hues, `from` and `to` in radians,
      # and a maximum distance to shift, `shift`, and returns
      # the new, shifted hue.
      def shift_hue(from:, to:, shift:)
        if from < to
          [from + shift, to].min
        elsif from > to
          [from - shift, to].max
        else
          to
        end
      end

      # Given `hue` in radians
      def hue_to_rgb(hue)
        hue_degrees = hue * 180 / Math::PI
        rgb = ::Color::HSL.new(hue_degrees, 100, 50).to_rgb
        [rgb.r, rgb.g, rgb.b].map { |e| e * 255 }
      end

      # Given two colors, returns the approximate relationship
      # between them.
      def rel(c1, c2)
        min_dist(c1, c2) <= PI_OVER_2 ? HEALING : DAMAGE
      end

      private

      def min_dist(c1, c2)
        r1 = c1.hue
        r2 = c2.hue
        counter_clockwise = (r1 - r2).abs
        min = [r1, r2].min
        max = [r1, r2].max
        clockwise = min + 2 * Math::PI - max
        [clockwise, counter_clockwise].min
      end

    end
  end
end
