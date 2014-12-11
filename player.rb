require_relative 'circle'

class Player

  attr_reader :window

  def initialize(window)
    @window = window
    @health = 50
    @image = Gosu::Image.new(window, Circle.new(@health), false)
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
    @x %= window.width
    @y %= window.height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
