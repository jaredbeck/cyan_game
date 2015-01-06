require_relative 'color_wheel'
require_relative 'entity'

module CyanGame
  class Player < Entity

    COLOR_ABSORPTION_RATE = 0.5 # degrees
    TWO_PI = 2 * Math::PI

    def initialize(*args)
      super
      @color = Color::CYAN
      @z = 1 # highest, on top of everything else
      @diameter = 50
    end

    def absorb_color_of(entity)
      new_hue = ColorWheel.shift_hue(
        from: color.hue,
        to: entity.color.hue,
        shift: COLOR_ABSORPTION_RATE)
      @color = Color.new(new_hue, 100, 50)
    end

    def accelerate(dx, dy)
      @vel_x += 5 * dx
      @vel_y += 5 * dy
    end

    def move(window)
      # accelerate
      @x += @vel_x
      @y += @vel_y

      # hit detection: border of window
      @x = radius if @x < radius
      @x = window.width - radius if @x > window.width - radius
      @y = radius if @y < radius
      @y = window.height - radius if @y > window.height - radius

      # decelerate
      @vel_x *= 0.50
      @vel_y *= 0.50
    end

    def reverse
      @vel_x = -@vel_x
      @vel_y = -@vel_y
    end

  end
end
