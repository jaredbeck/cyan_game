require 'json'
require_relative 'color'
require_relative 'entity'
require_relative 'player'

class World

  attr_reader :window

  def initialize(window, file)
    @window = window
    w = window.width
    h = window.height

    @player = Player.new(window, Color::CYAN)
    @player.warp(w / 2, h / 2)

    parsed = JSON.parse(file.read)
    window.caption = parsed['name']

    @entities = parsed['entities'].map do |e|
      Entity.new(window, Color::YELLOW, e['coordinates'])
    end

    @entities.each do |e|
      e.warp(*polar_to_cartesian(e.coordinates, window))
    end
  end

  def debug_str
    '(%d, %d, %d)' % [@player.x, @player.y, @player.radius]
  end

  def draw
    @player.draw
    @entities.each(&:draw)
  end

  def game_over?
    @player.radius <= 0
  end

  def polar_to_cartesian(coordinates, window)
    d = coordinates['distance'] * window.smallest_dimension
    r = coordinates['radians']
    w = window.width
    h = window.height
    dx = Math.cos(r) * d
    dy = Math.sin(r) * d
    x = (w / 2) + dx
    y = (h / 2) + dy
    [x, y]
  end

  def update
    @entities.each do |e|
      d = Gosu.distance(@player.x, @player.y, e.x, e.y)
      if d < @player.radius + e.radius
        @player.damage(1)
        e.damage(1)
      end
    end

    if window.button_down? Gosu::KbLeft
      @player.accelerate(-1, 0)
    end
    if window.button_down? Gosu::KbRight
      @player.accelerate(+1, 0)
    end
    if window.button_down? Gosu::KbUp
      @player.accelerate(0, -1)
    end
    if window.button_down? Gosu::KbDown
      @player.accelerate(0, +1)
    end

    @player.move
  end

end
