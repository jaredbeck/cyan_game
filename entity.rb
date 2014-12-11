require_relative 'circle'

class Entity

  attr_reader :radius, :window

  def initialize(window, color)
    @window = window
    @radius = 50
    @image = Gosu::Image.new(window, Circle.new(radius, color), false)
    @x = @y = @vel_x = @vel_y = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def accelerate(dx, dy)
    @vel_x += 1 * dx
    @vel_y += 1 * dy
  end

  def move
    @x += @vel_x
    @y += @vel_y

    @x = radius if @x < radius
    @x = window.width - radius if @x > window.width - radius
    @y = radius if @y < radius
    @y = window.height - radius if @y > window.height - radius

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw(@x - radius, @y - radius, 1)
  end

end
