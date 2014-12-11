require 'gosu'
require_relative 'color'
require_relative 'player'

class CyanWindow < Gosu::Window

  CYAN = Color.new(0, 255, 255)
  YELLOW = Color.new(255, 255, 0)

  def initialize
    h = Gosu.available_height
    w = Gosu.available_width
    super(w, h, false)
    self.caption = 'Cyan'

    @player = Player.new(self, CYAN)
    @player.warp(w / 3, h / 2)

    @boss = Entity.new(self, YELLOW)
    @boss.warp(w * (2.0 / 3), h / 2)
  end

  def update
    if button_down? Gosu::KbLeft
      @player.accelerate(-1, 0)
    end
    if button_down? Gosu::KbRight
      @player.accelerate(+1, 0)
    end
    if button_down? Gosu::KbUp
      @player.accelerate(0, -1)
    end
    if button_down? Gosu::KbDown
      @player.accelerate(0, +1)
    end
    @player.move
  end

  def draw
    @player.draw
    @boss.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = CyanWindow.new
window.show
