module CyanGame
  class Circle

    # In the future, we may want a few static images of different
    # sizes, to avoid scaling artifacts.
    CIRCLE_250 = 'data/circle_250.png'
    IMAGE_DIAMETER = 250

    def initialize
      @image = Gosu::Image.new(CIRCLE_250, false)
    end

    # `draw` the image at the current position.  Happily, gosu
    # handles scaling and hue-shifting for us.  We may find that
    # hue-shifting every entity on every draw may not perform well
    # for lots of entities, but seems fine so far with a dozen.
    def draw(x, y, z, diameter, color)
      d = diameter.to_f
      r =  d / 2
      scale_factor = d / IMAGE_DIAMETER
      @image.draw(x - r, y - r, z, scale_factor, scale_factor, color.to_i)
    end

  end
end
