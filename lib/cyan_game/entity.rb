require_relative 'circle'

module CyanGame
  class Entity

    IMAGE_DIAMETER = 250

    attr_accessor :color, :diameter
    attr_reader :coordinates, :x, :y

    def initialize(window, attr = {})
      @window = window
      @x = @y = @vel_x = @vel_y = 0.0
      @z = 0.9
      unless attr.empty?
        rgb = attr['color'].values_at(*%w[r g b])
        @color = Color.new(*rgb)
        @coordinate_fns = attr['coordinates']
        @diameter = attr['diameter']
      end
    end

    def draw
      scale_factor = diameter.to_f / IMAGE_DIAMETER
      image.draw(@x - radius, @y - radius, @z, scale_factor, scale_factor)
    end

    # Given time `t` returns angle in radians
    def eval_angle(fn_str, t)
      π = Math::PI
      eval(fn_str) # TODO: Don't eval, it's insecure
    end

    # Given angle `ø` returns polar radius as a decimal percent of window
    def eval_radius(fn_str, ø)
      eval(fn_str) # TODO: Don't eval, it's insecure
    end

    def image
      @_image ||= Gosu::Image.new(@window, Circle.new(IMAGE_DIAMETER / 2, color), false)
    end

    def rebuild_image
      # TODO: duplicated code with `image`
      @_image = Gosu::Image.new(@window, Circle.new(IMAGE_DIAMETER / 2, color), false)
    end

    # Given the `window` and a timestamp `t`, move the entity
    # Evaluate the polar fns. from the config, then
    # convert polar coord. to cartesian.
    def move(window, t)
      angle = eval_angle(@coordinate_fns['angle'], t) # polar coord. angle
      radius = eval_radius(@coordinate_fns['radius'], angle) # polar coord. radius
      @x, @y = polar_to_cartesian(angle, radius, window)
    end

    # angle - in radians
    # radius - decimal 0 .. 1
    def polar_to_cartesian(angle, radius, window)
      if radius < -1 || radius > 1
        raise Errors::PolarRadiusOutOfBounds, "Expect 0 .. 1, got #{radius}"
      end
      d = radius * window.smallest_dimension
      w = window.width
      h = window.height
      dx = Math.cos(angle) * d
      dy = Math.sin(angle) * d
      x = (w / 2) + dx
      y = (h / 2) + dy
      [x, y]
    end

    def radius
      diameter.to_f / 2
    end

    def warp(x, y)
      @x, @y = x, y
    end

  end
end
