require_relative 'dragon'

class IceDragon < Dragon

  def initialize(name:, player_flag:)
    @name = name
    @hp = 150
    @sp = 150
    @atc = 20
    @matg = 50
    @def = 10
    @mdef = 30
    @type = "ice"
    @points = nil
    @conditions = {}
    @player = player_flag
  end
end
