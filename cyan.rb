require 'gosu'
require 'pry'
require_relative 'errors'
require_relative 'world'

module Cyan
  class Window < Gosu::Window

    STATE_GAME_OVER = 1
    STATE_PLAY = 2
    STATE_WORLD_READY = 3

    attr_reader :font

    def initialize
      h = Gosu.available_height
      w = Gosu.available_width
      super(w, h, false)
      self.caption = 'Cyan'
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
      random_world
      @state = STATE_WORLD_READY
    end

    def update
      case @state
        when STATE_PLAY
          @world.update
          @state = STATE_GAME_OVER if @world.game_over?
        when STATE_GAME_OVER, STATE_WORLD_READY
          # noop
        else
          raise Cyan::Errors::InvalidGameState
      end
    end

    def draw
      case @state
        when STATE_WORLD_READY
          draw_centered_text(@world.title, 0, -20)
          draw_centered_text(@world.subtitle, 0, +20)
        when STATE_PLAY
          @world.draw
          @font.draw(@world.debug_str, 10, 10, 1, 1.0, 1.0, CyanGame::Color::WHITE.to_i)
        when STATE_GAME_OVER
          draw_centered_text('GAME OVER', 0, -20)
          draw_centered_text('We\'ll meet again someday soon.', 0, +20)
        else
          raise Cyan::Errors::InvalidGameState
      end
    end

    def draw_centered_text(str, off_x, off_y)
      x = width / 2
      y = height / 2
      font.draw_rel(str, x + off_x, y + off_y, 1, 0.5, 0.5, 1.0, 1.0, CyanGame::Color::WHITE.to_i)
    end

    def button_down(id)
      case id
        when Gosu::KbEscape
          case @state
            when STATE_WORLD_READY, STATE_GAME_OVER
              close
            when STATE_PLAY
              ready
            else
              raise Cyan::Errors::InvalidGameState
          end
        else
          case @state
            when STATE_WORLD_READY
              play
            when STATE_GAME_OVER
              random_world
              ready
            else
              # noop
          end
      end
    end

    def play
      @state = STATE_PLAY
    end

    def random_world
      @world = World.new(self, random_world_file)
    end

    def random_world_file
      File.new(random_world_path)
    end

    def random_world_path
      Dir['worlds/*.json'].sample
    end

    def ready
      @state = STATE_WORLD_READY
    end

    def smallest_dimension
      @_smallest_dimension ||= [width, height].min
    end
  end
end

Cyan::Window.new.show
