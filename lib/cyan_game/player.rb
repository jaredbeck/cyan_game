require_relative 'circle'
require_relative 'color_wheel'
require_relative 'entity'

module CyanGame
  class Player < Entity

    COLOR_ABSORPTION_RATE = Math::PI / 100 # radians
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
      new_rgb = ColorWheel.hue_to_rgb(new_hue)
      @color = Color.new(*new_rgb)
    end

    def accelerate(dx, dy)
      @vel_x += 5 * dx
      @vel_y += 5 * dy
    end

    def change_color
      new_hue = @color.hue + 2 * Math::PI / 3
      if new_hue > TWO_PI
        new_hue -= TWO_PI
      end
      r, g, b = ColorWheel.hue_to_rgb(new_hue)
      @color = Color.new(r, g, b)
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

    def score
      (@diameter * 1_000_000_000).to_i
    end

  end
end
