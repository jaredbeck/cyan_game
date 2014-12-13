require 'json'
require_relative 'lib/cyan_game/color'
require_relative 'lib/cyan_game/color_wheel'
require_relative 'entity'
require_relative 'player'

class World

  attr_reader :subtitle, :title, :window

  def initialize(window, file)
    @window = window
    w = window.width
    h = window.height

    @player = Player.new(window, CyanGame::Color::CYAN)
    @player.warp(w / 2, h / 2)

    parsed = JSON.parse(file.read)
    @title = parsed['title']
    @subtitle = parsed['subtitle']
    window.caption = @title

    @entities = parsed['entities'].map do |e|
      rgb = e['color'].values_at(*%w[r g b])
      Entity.new(window, CyanGame::Color.new(*rgb), e['coordinates'])
    end

    @entities.each do |e|
      e.warp(*polar_to_cartesian(e.coordinates, window))
    end
  end

  def draw
    @player.draw
    @entities.each(&:draw)
  end

  def game_over?
    @player.radius <= 0
  end

  def hit(e1, e2)
    e1.damage(1)
    e2.damage(1)
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
        hit(@player, e)
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

    @player.move(@window)
  end

end
