require 'json'
require_relative 'color'
require_relative 'color_wheel'
require_relative 'entity'
require_relative 'player'

module CyanGame
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

    def change_player_color
      @player.change_color
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

    def hit(player, entity)
      delta = ColorWheel.rel(player.color, entity.color)
      player.diameter += delta
      entity.diameter -= 1

      # Remove entities with diameter 0
      @entities.delete_if { |e|
        e.diameter <= 0
      }
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
end
