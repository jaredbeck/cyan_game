module CyanGame
  class Timer

    attr_reader :ms

    def initialize
      @sec = 0
    end

    def pause
      raise 'resume must happen before pause' if @resumed_at.nil?
      @sec += Time.now - @resumed_at
    end

    def resume
      @resumed_at = Time.now
    end

    def started?
      !@resumed_at.nil?
    end

    def to_s
      minutes = (@sec.to_f / 60).floor
      sec = @sec - (minutes * 60)
      '%02d:%02d' % [minutes, sec.floor]
    end

  end
end
