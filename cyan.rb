require 'gosu'
require_relative 'color'
require_relative 'player'

class CyanWindow < Gosu::Window

  CYAN = Color.new(0, 255, 255)
  YELLOW = Color.new(255, 255, 0)

  STATE_GAME_ON = 1
  STATE_GAME_OVER = 2

  def initialize
    h = Gosu.available_height
    w = Gosu.available_width
    super(w, h, false)
    self.caption = 'Cyan'

    @player = Player.new(self, CYAN)
    @player.warp(w / 3, h / 2)

    @boss = Entity.new(self, YELLOW)
    @boss.warp(w * (2.0 / 3), h / 2)

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @state = STATE_GAME_ON
  end

  def update
    if @player.radius <= 0
      @state = STATE_GAME_OVER
    end

    @d = Gosu.distance(@player.x, @player.y, @boss.x, @boss.y)
    if [@player.radius, @boss.radius].max > @d
      @player.damage(1)
      @boss.damage(1)
    end

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
    debug_str = '(%d, %d, %d) (%d, %d, %d) %d' % [@player.x, @player.y, @player.radius, @boss.x, @boss.y, @boss.radius, @d]
    @font.draw(debug_str, 10, 10, 1, 1.0, 1.0, 0xffffff00)

    if @state == STATE_GAME_OVER
      @font.draw('GAME OVER', width / 2, height / 2, 1, 1.0, 1.0, 0xffffff00)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = CyanWindow.new
window.show
