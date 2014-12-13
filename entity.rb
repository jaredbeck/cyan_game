require_relative 'circle'

class Entity

  attr_reader :color, :coordinates, :radius, :x, :y

  def initialize(window, attr = {})
    @window = window
    @x = @y = @vel_x = @vel_y = 0.0
    @z = 0.9
    unless attr.empty?
      rgb = attr['color'].values_at(*%w[r g b])
      @color = CyanGame::Color.new(*rgb)
      @coordinates = attr['coordinates']
      @radius = @max_radius = attr['radius']
    end
  end

  def damage(d)
    @radius = [0, @radius - d].max
  end

  def heal(d)
    @radius = [@max_radius, @radius + d].min
  end

  def image
    @_image ||= Gosu::Image.new(@window, Circle.new(@max_radius, color), false)
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
    image.draw(@x - radius, @y - radius, @z, scale_factor, scale_factor)
  end

end
