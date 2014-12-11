require_relative 'circle'
require_relative 'entity'

class Player < Entity

  def initialize(*args)
    super
    @z = 1 # highest, on top of everything else
  end

end
