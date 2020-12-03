require_relative 'frame_dragon'
require_relative 'ice_dragon'

class Dragon

  include FrameDragon
  include IceDragon

  attr_reader :name,
              :hp,
              :sp,
              :atc,
              :matg,
              :def,
              :mdef,
              :type,
              :player

  attr_accessor :points,
                :conditions

  def initialize(name:, type:, player_flag:)
    @name = name
    @player = player_flag
    @points = nil
    @conditions = {}
    @hp = nil
    @sp = nil
    @atc = nil
    @matg = nil
    @def = nil
    @mdef = nil
    @type = type

    set_status_by_type

  end

  def set_status_by_type
    case @type
    when "frame"
      frame_dragon_base_ststus
    when "ice"
      ice_dragon_base_ststus
    end
  end

end
