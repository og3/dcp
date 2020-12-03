require './dragon/dragon.rb'
require './battle/battle.rb'

enemy_dragon = Dragon.new(name: "バーニル", type: "frame", player_flag: false)

puts "#{enemy_dragon.hp}"

# FRAME = { NAME: "バーニル", HP: 150, SP:100, ATC: 30, MATC: 10, DEF: 20, MDEF: 5, TYPE: "frame", POINTS: 0, PLAYER: true, CONDITIONS: {} }
# ICE = { NAME: "アイピス", HP: 150, SP:150, ATC: 10, MATC: 30, DEF: 10, MDEF: 20, TYPE: "ice", POINTS: 0, PLAYER: false, CONDITIONS: {} }
# THNDER = { NAME: "ヴォルム", HP: 100, SP:100, ATC: 20, MATC: 20, DEF: 20, MDEF: 20, TYPE: "thunder", POINTS: 0, PLAYER: false, CONDITIONS: {} }
# METAL = { NAME: "ダルキス", HP: 200, SP:100, ATC: 10, MATC: 10, DEF: 40, MDEF: 40, TYPE: "metal", POINTS: 0, PLAYER: false, CONDITIONS: {} }



