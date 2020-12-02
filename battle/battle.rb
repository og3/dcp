module Battle

  def start
  end

  def finish
  end
  
  def strike(owner:, target:)
    action_data = { action_name: "打撃", action_type: "strike", damage: nil, wait: 1, owner: owner[:NAME], target: target[:NAME] }
    action_data[:damage] = if owner[:SP] >= 50
                              (owner[:ATC] * rand(0.8..2)).to_i
                            else
                              puts "SPが足りないので力が出ない..."
                              (owner[:ATC] * rand(0.3..1)).to_i
                            end
    owner[:SP] -= 50
    $actions << action_data
  end

  def calc_strike(order)
    owner = $entry_players.find{|player| player[:NAME] == order[:owner] }
    target = $entry_players.find{|player| player[:NAME] == order[:target] }

    puts "#{order[:owner]}の#{order[:action_name]}!!"
    if target[:CONDITIONS].keys.include?("defense")
      puts "#{target[:NAME]}は防御したので無傷だった"
    else
      puts "#{order[:target]}に#{order[:damage]}のダメージ！"
      target[:HP] -= order[:damage]
      if target[:HP] <= 0
        puts "#{target[:NAME]}は気絶した.."
        target[:CONDITIONS][:fainted] = 2
      end
    end
  end

  def defense(owner:)
    action_data = { action_name: "防御", action_type: "defense", damage: nil, wait: 0, owner: owner[:NAME] }
    $actions << action_data
  end

  def calc_defense(order)
    owner = $entry_players.find{|player| player[:NAME] == order[:owner] }
    puts "#{owner[:NAME]}は防御している"
    owner[:CONDITIONS][:defense] = 1
  end

  def counter(owner:)
    action_data = { action_name: "カウンター", action_type: "counter", damage: nil, wait: 0, owner: owner[:NAME] }
    action_data[:damage] = if owner[:SP] >= 30
                              (owner[:ATC] * rand(0.8..1)).to_i
                            else
                              puts "SPが足りないので力が出ない..."
                              (owner[:ATC] * rand(0.3..0.5)).to_i
                            end
    owner[:SP] -= 30
    $actions << action_data
  end

  def spell_attack(player)
  end

  def shield(player)
  end

  def pray
  end

  def calc_condition
    has_condition_players = $entry_players.each do |player|
                              next if player[:CONDITIONS].empty?
                              player[:CONDITIONS].each do |condition, turn|
                                turn -= 1
                              end
                            end
  end

  def opening(*entry_players)
    $entry_players = entry_players
    puts "エントリー："
    $entry_players.each_with_index do |player, index|
      puts "#{index + 1}: #{player}"
    end
    set_player
    set_enemy
    puts "戦闘開始"
  end

  def set_player
    $player = $entry_players.find{|player| player[:PLAYER] == true }
  end

  def set_enemy
    $enemys = $entry_players.find_all{|player| player[:PLAYER] == false }
  end

  def player_select_action
    puts "#{$player}"
    puts "#{$enemys}"
    puts "#{$player[:NAME]}はどうする？"
    puts "1:打撃(消費SP:50) 2:防御(消費SP:0)"
    command = gets.to_i

    $player_action = case command
                      when 1
                        puts "ターゲットを選んでください"
                        $enemys.each_with_index do |enemy, index|
                          puts "#{index}: #{enemy[:NAME]} HP #{enemy[:HP]}"
                        end
                        target = gets.to_i
                        strike(owner: $player, target: $enemys[target])
                      when 2
                        defense(owner: $player)
                      end
  end

  def enemy_targets(action_enemy)
    targets = $enemys.find_all{|enemy| enemy[:NAME] != action_enemy[:NAME] }
    targets << $player
  end

  def enemy_select_action(enemy)
    command = rand(1..2)
    $enemy_action = case command
                      when 1
                        target = enemy_targets(enemy)[rand(0..2)]
                        strike(owner: enemy, target: target)
                      when 2
                        defense(owner: enemy)
                      end
  end

  def sort_order_of_action(actions)
    $order_of_actions = actions.sort_by{|action| action[:wait] } 
    puts "行動順"
    $order_of_actions.each_with_index do |order, index|
      puts "#{index + 1}: #{order}"
    end
  end

  def execute_orders(order_of_actions)
    order_of_actions.each do |order|
      case order[:action_type]
      when "strike"
        calc_strike(order)
      when "defense"
        calc_defense(order)
      when "counter"
      end
    end
  end

  def set_action_datas
    $actions = []
  end

  opening(FRAME, ICE, THNDER, METAL)
  4.times do |time|
    puts "#{time + 1}/4ターン"
    set_action_datas
    player_select_action
    $enemys.each do |enemy|
      enemy_select_action(enemy)
    end
    sort_order_of_action($actions)
    execute_orders($order_of_actions)
    calc_condition
    puts "#{time + 1}/4ターン終了"
    puts "#{$entry_players}"
  end
  puts "#{$entry_players}"

  # 4回繰り返す
  # select_action
  # enemy_select_action($enemy)
end