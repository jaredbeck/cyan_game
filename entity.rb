require_relative 'circle'

class Entity

  attr_reader :color, :coordinates, :radius, :x, :y

  def initialize(window, color, coordinates = {})
    @color = color
    @coordinates = coordinates
    @radius = @max_radius = 50
    @image = Gosu::Image.new(window, Circle.new(@max_radius, color), false)
    @x = @y = @vel_x = @vel_y = 0.0
    @z = 0.9
  end

  def damage(d)
    @radius -= d
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def accelerate(dx, dy)
    @vel_x += 0.5 * dx
    @vel_y += 0.5 * dy
  end

  def move(window)
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
    scale_factor = radius.to_f / @max_radius
    @image.draw(@x - radius, @y - radius, @z, scale_factor, scale_factor)
  end

end
