require 'gosu'
require_relative 'player'

class CyanWindow < Gosu::Window
  def initialize
    h = Gosu.available_height
    w = Gosu.available_width
    super(w, h, false)
    self.caption = 'Cyan'
    @player = Player.new(self)
    @player.warp(w / 2, h / 2)
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
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = CyanWindow.new
window.show
