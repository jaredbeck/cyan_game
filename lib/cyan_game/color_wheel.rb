require 'color'

module CyanGame
  module ColorWheel

    # If healing is greater than damage, the game is easier.
    # Does that make it more fun?
    DAMAGE  = -1
    HEALING = +1.1

    FULL_CIRCLE = 360
    QUARTER_CIRCLE = 90

    class << self

      # `shift_hue` takes two hues, `from` and `to` in degrees,
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

      # Given two colors, returns the approximate relationship
      # between them.
      def rel(c1, c2)
        min_dist(c1, c2) <= QUARTER_CIRCLE ? HEALING : DAMAGE
      end

      private

      # Returns minimum distance, in degrees of hue, between two colors.
      def min_dist(c1, c2)
        r1 = c1.hue
        r2 = c2.hue
        counter_clockwise = (r1 - r2).abs
        min = [r1, r2].min
        max = [r1, r2].max
        clockwise = min + FULL_CIRCLE - max
        [clockwise, counter_clockwise].min
      end

    end
  end
end
