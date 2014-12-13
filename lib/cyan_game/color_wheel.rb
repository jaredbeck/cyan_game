require 'color'

module CyanGame
  module ColorWheel

    # A sixth of a circle is π / 3 radians
    PI_OVER_3 = Math::PI / 3.0

    # Complementary colors are 2π / 3 radians apart
    COMPLEMENT = 2 * PI_OVER_3

    class << self

      # Given RGB values, return position on color wheel, in
      # radians, where yellow is 0, e.g. red is π / 3.
      # Probably a terrible implementation.  Other interesting ideas here:
      # http://stackoverflow.com/questions/8507885/shift-hue-of-an-rgb-color
      def rad(r, g, b)
        ::Color::RGB.new(r, g, b).to_hsl.hue * Math::PI / 180
      end

      # Given two colors, returns the approximate relationship
      # between them, e.g. red and green are `:complementary`.
      def rel(c1, c2)
        dist = min_dist(c1, c2)
        if dist >= 1.99 * PI_OVER_3
          :complementary # approximately speaking
        elsif dist < PI_OVER_3
          :adjacent # similar concept to "analogous colors"
        else
          :other
        end
      end

      private

      def min_dist(c1, c2)
        r1 = c1.rad
        r2 = c2.rad
        counter_clockwise = (r1 - r2).abs
        min = [r1, r2].min
        max = [r1, r2].max
        clockwise = min + 2 * Math::PI - max
        [clockwise, counter_clockwise].min
      end

    end
  end
end
