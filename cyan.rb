require 'gosu'
require_relative 'world'

class CyanWindow < Gosu::Window

  STATE_GAME_ON = 1
  STATE_GAME_OVER = 2

  def initialize
    h = Gosu.available_height
    w = Gosu.available_width
    super(w, h, false)
    self.caption = 'Cyan'

    @world = World.new(self)

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @state = STATE_GAME_ON
  end

  def update
    if @world.game_over?
      @state = STATE_GAME_OVER
    end

    @world.update
  end

  def draw
    @world.draw
    @font.draw(@world.debug_str, 10, 10, 1, 1.0, 1.0, 0xffffff00)

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
