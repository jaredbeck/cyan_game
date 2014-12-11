require_relative 'color'
require_relative 'entity'
require_relative 'player'

class World

  attr_reader :window

  def initialize(window)
    @window = window
    w = window.width
    h = window.height

    @player = Player.new(window, Color::CYAN)
    @player.warp(w / 3, h / 2)

    @boss = Entity.new(window, Color::YELLOW)
    @boss.warp(w * (2.0 / 3), h / 2)
  end

  def debug_str
    '(%d, %d, %d) (%d, %d, %d)' %
      [@player.x, @player.y, @player.radius, @boss.x, @boss.y, @boss.radius]
  end

  def draw
    @player.draw
    @boss.draw
  end

  def game_over?
    @player.radius <= 0
  end

  def update
    d = Gosu.distance(@player.x, @player.y, @boss.x, @boss.y)
    if d < @player.radius + @boss.radius
      @player.damage(1)
      @boss.damage(1)
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
