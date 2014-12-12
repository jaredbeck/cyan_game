require 'gosu'
require 'pry'
require_relative 'errors'
require_relative 'world'

module Cyan
  class Window < Gosu::Window

    STATE_GAME_OVER = 1
    STATE_PLAY = 2

    def initialize
      h = Gosu.available_height
      w = Gosu.available_width
      super(w, h, false)
      self.caption = 'Cyan'
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
      @world = World.new(self, random_world_file)
      @state = STATE_PLAY
    end

    def update
      case @state
        when STATE_PLAY
          @world.update
          @state = STATE_GAME_OVER if @world.game_over?
        when STATE_GAME_OVER
          # noop
        else
          raise Cyan::Errors::InvalidGameState
      end
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

    def random_world_file
      File.new(random_world_path)
    end

    def random_world_path
      Dir['worlds/*.json'].sample
    end

    def smallest_dimension
      @_smallest_dimension ||= [width, height].min
    end
  end
end

Cyan::Window.new.show
