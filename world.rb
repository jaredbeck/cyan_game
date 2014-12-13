require 'json'
require_relative 'lib/cyan_game/color'
require_relative 'lib/cyan_game/color_wheel'
require_relative 'entity'
require_relative 'player'

class World

  attr_reader :subtitle, :title, :window

  def initialize(window, file)
    @t = 0 # world time

    @window = window
    w = window.width
    h = window.height

    @player = Player.new(window)
    @player.warp(w / 2, h / 2)

    parsed = JSON.parse(file.read)
    @title = parsed['title']
    @subtitle = parsed['subtitle']
    window.caption = @title

    @entities = parsed['entities'].map do |e|
      Entity.new(window, e)
    end

    @entities.each do |e| e.move(window, @t) end
  end

  def debug_str
    '(%d, %d, %d, %d)' % [@player.x, @player.y, @player.radius, @entities.length]
  end

  def draw
    @player.draw
    @entities.each(&:draw)
  end

  def game_over?
    @player.radius <= 0
  end

  def hit(e1, e2)
    case CyanGame::ColorWheel.rel(e1.color, e2.color)
      when :complementary
        e1.damage(1)
        e2.damage(1)
      when :adjacent
        e1.heal(1)
        e2.damage(1)
      else
        # noop
    end
  end

  def update
    @t += 0.05

    @entities.each do |e|
      e.move(window, @t)
    end

    # hit detection between player and entities
    @entities.each do |e|
      d = Gosu.distance(@player.x, @player.y, e.x, e.y)
      if d <= (@player.diameter + e.diameter) / 2
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
