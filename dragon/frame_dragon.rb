require_relative 'dragon'

class FrameDragon < Dragon

  def initialize(name:, player_flag:)
    @name = name
    @hp = 150
    @sp = 100
    @atc = 50
    @matg = 10
    @def = 20
    @mdef = 5
    @type = "frame"
    @points = nil
    @conditions = {}
    @player = player_flag
  end
end
