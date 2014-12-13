require 'gosu'
require 'pry'
require_relative 'lib/cyan_game/quotations'
require_relative 'errors'
require_relative 'world'

module CyanGame
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
      @quotations = CyanGame::Quotations.new
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
      random_world
      ready
    end

    def update
      case @state
        when STATE_PLAY
          @world.update
          @state = STATE_GAME_OVER if @world.game_over?
        when STATE_GAME_OVER, STATE_WORLD_READY
          # noop
        else
          raise CyanGame::Errors::InvalidGameState
      end
    end

    def draw
      case @state
        when STATE_WORLD_READY
          draw_quotation(@quotation)
        when STATE_PLAY
          @world.draw
          @font.draw(@world.debug_str, 10, 10, 1, 1.0, 1.0, CyanGame::Color::WHITE.to_i)
        when STATE_GAME_OVER
          draw_centered_text('GAME OVER', 0, -20)
          draw_centered_text('We\'ll meet again someday soon.', 0, +20)
        else
          raise CyanGame::Errors::InvalidGameState
      end
    end

    def draw_quotation(q)
      draw_centered_text(q['text'].gsub("\n", ' '), 0, -40)
      draw_centered_text(q['author'].gsub("\n", ' '), 0, 0)
      draw_centered_text(q['source'].gsub("\n", ' '), 0, +20)
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
              raise CyanGame::Errors::InvalidGameState
          end
        when Gosu::KbSpace
          @world.change_player_color
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
      @quotation = @quotations.sample
      @state = STATE_WORLD_READY
    end

    def smallest_dimension
      @_smallest_dimension ||= [width, height].min
    end
  end
end

CyanGame::Window.new.show
