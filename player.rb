require_relative 'circle'
require_relative 'entity'

class Player < Entity

  def initialize(*args)
    super
    @color = CyanGame::Color::CYAN
    @z = 1 # highest, on top of everything else
    @diameter = @max_diameter = 50
  end

  def accelerate(dx, dy)
    @vel_x += 0.5 * dx
    @vel_y += 0.5 * dy
  end

  def move(window)
    # accell
    @x += @vel_x
    @y += @vel_y

    # hit detection: border of window
    @x = radius if @x < radius
    @x = window.width - radius if @x > window.width - radius
    @y = radius if @y < radius
    @y = window.height - radius if @y > window.height - radius

    # decell
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

end
