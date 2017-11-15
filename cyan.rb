require 'active_support'
require 'gosu'
require_relative 'lib/cyan_game/quotations'
require_relative 'lib/cyan_game/errors'
require_relative 'lib/cyan_game/world'
require_relative 'lib/cyan_game/timer'

module CyanGame
  class Window < Gosu::Window
    include ActiveSupport::NumberHelper

    STATE_GAME_OVER = 1
    STATE_PLAY = 2
    STATE_WORLD_READY = 3
    STATE_VICTORY = 4

    attr_reader :font

    def initialize(world_file = nil)
      h = Gosu.available_height
      w = Gosu.available_width
      super(w, h, false)
      self.caption = 'Cyan'
      restart_timer
      @quotations = Quotations.new
      @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
      @world_file = world_file
      create_world(@world_file)
      ready
    end

    def create_world(world_file)
      world_file.nil? ? random_world : load_world(world_file)
    end

    def update
      case @state
        when STATE_PLAY
          @world.update
          if @world.victory?
            victory
          elsif @world.game_over?
            @state = STATE_GAME_OVER
          end
        when STATE_GAME_OVER, STATE_WORLD_READY, STATE_VICTORY
          # noop
        else
          raise Errors::InvalidGameState
      end
    end

    def draw
      case @state
        when STATE_WORLD_READY
          draw_quotation(@quotation)
        when STATE_PLAY
          @world.draw
        when STATE_GAME_OVER
          draw_centered_text('GAME OVER', 0, -20)
          draw_centered_text('We\'ll meet again someday soon.', 0, +20)
        when STATE_VICTORY
          draw_centered_text('VICTORY!', 0, -20)
          draw_centered_text("#{@timer.to_s}", 0, 0)
        else
          raise Errors::InvalidGameState
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
      font.draw_rel(str, x + off_x, y + off_y, 1, 0.5, 0.5, 1.0, 1.0, Color::WHITE.to_i)
    end

    def button_down(id)
      case id
        when Gosu::KbEscape
          case @state
            when STATE_WORLD_READY, STATE_GAME_OVER, STATE_VICTORY
              close
            when STATE_PLAY
              ready
            else
              raise Errors::InvalidGameState
          end
        else
          case @state
            when STATE_WORLD_READY
              play
            when STATE_GAME_OVER, STATE_VICTORY
              create_world(@world_file)
              ready
              restart_timer
            else
              # noop
          end
      end
    end

    def load_world(world_file)
      @world = World.new(self, File.new(world_file))
    end

    def pause_timer
      @timer.pause
    end

    def play
      @state = STATE_PLAY
      resume_timer
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
      pause_timer if timer_started?
    end

    def restart_timer
      @timer = Timer.new
    end

    def resume_timer
      @timer.resume
    end

    def smallest_dimension
      @_smallest_dimension ||= [width, height].min
    end

    def timer_started?
      @timer.started?
    end

    def victory
      @state = STATE_VICTORY
      pause_timer
    end
  end
end

CyanGame::Window.new(*ARGV).show
