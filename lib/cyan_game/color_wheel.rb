module CyanGame
  module ColorWheel

    # A sixth of a circle is π / 3 radians
    PI_OVER_3 = Math::PI / 3.0

    class << self

      # Given RGB values, return position on color wheel, in radians.
      #
      # 0.00  yellow
      # 1.06  red
      # 2.09  magenta
      # 3.14  blue
      # 4.18  cyan
      # 5.24  green
      #
      # This is probably a terrible implementation.  There are some
      # interesting other ideas here:
      # http://stackoverflow.com/questions/8507885/shift-hue-of-an-rgb-color
      #
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
            3 * PI_OVER_3 + g.to_f / 255.0 * PI_OVER_3
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

    end
  end
end
