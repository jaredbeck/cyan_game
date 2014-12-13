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
        if r == 255
          # third-sector: from yellow to magenta
          if b == 0
            # sixth-sector: from yellow to red, green decreases
            (255 - g).to_f / 255.0 * PI_OVER_3
          elsif g == 0
            # sixth-sector: from red to magenta, blue increases
            PI_OVER_3 + b.to_f / 255.0 * PI_OVER_3
          end
        elsif r == 0
          # third-sector: from blue to green
          if b == 255
            # sixth-sector: from blue to cyan, green increases
            Math::PI + g.to_f / 255.0 * PI_OVER_3
          elsif g == 255
            # sixth-sector: from cyan to green, blue decreases
            4 * PI_OVER_3 + (255 - b).to_f / 255.0 * PI_OVER_3
          end
        else
          if g == 0
            # sixth-sector: from magenta to blue (g = 0, b = 255) red decreases
            2 * PI_OVER_3 + (255 - r).to_f / 255.0 * PI_OVER_3
          else
            # sixth-sector: or from green to yellow (g = 255, b = 0) red increases
            5 * PI_OVER_3 + r.to_f / 255.0 * PI_OVER_3
          end
        end
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
