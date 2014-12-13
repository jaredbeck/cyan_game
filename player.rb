require_relative 'circle'
require_relative 'entity'

class Player < Entity

  def initialize(*args)
    super
    @color = CyanGame::Color::CYAN
    @z = 1 # highest, on top of everything else
    @radius = @max_radius = 50
  end

end
