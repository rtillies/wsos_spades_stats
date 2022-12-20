module Searchable
  def find_by_name(name_stub)
    @teams.each do |c, team|
      if team.team_name.downcase.include? (name_stub)
        return team
      end
    end
  end

  def find_by_code(code)
    @teams.each do |c, team|
      if team.code.include? (code)
        return team
      end
    end
  end

  def get_team
    puts "Enter team name: "
    team_stub = STDIN.gets.chomp
    team = find_by_name(team_stub.downcase)
    # puts "Team name: #{team.team_name}"
    # team
  end

  def get_choice
    puts "(C)onf | (D)ivision | (H)ome | (A)way"
    puts "(W)ins | (L)osses   | (T)eam | (X) All Games"
    choice = STDIN.gets.chomp
  end

  def show_games(team)
    code = team.code

    selected = @games.select {|game| game.home_code == code || game.away_code == code}
    # puts selected.size

    puts "#{team.team_name} (#{team.wins}-#{team.losses})"
    puts "#{team.conference} | #{team.division}"
    choice = get_choice.downcase
    puts "Choice: #{choice}"

    if choice == "c"
      selected.select! {|game| game.conf_game?}
    elsif choice == "d"
      selected.select! {|game| game.div_game?}
    elsif choice == "h"
      selected.select! {|game| code == game.home_code}
    elsif choice == "a"
      selected.select! {|game| code == game.away_code}
    elsif choice == "w"
      selected.select! {|game| code == game.winning_team}
    elsif choice == "l"
      selected.select! {|game| code == game.losing_team}
    elsif choice == "t"
      other = get_team
      selected.select! {|game| game.home_code == other.code || game.away_code == other.code}
    end

    puts "#{selected.size} games:"

    selected.each do |game|
      if game.home_code == code || game.away_code == code
        if code == game.home_code
          home_away = "HOME"
          other_team = find_by_code(game.away_code).team_name
        else
          home_away = "AWAY"
          other_team = find_by_code(game.home_code).team_name
        end

        if code == game.winning_team
          win_loss = "WIN "
        else
          win_loss = "LOSS"
        end

        date = game.date
        # winner = find_by_code(game.winning_team).team_name
        # loser = find_by_code(game.losing_team).team_name
        puts "  #{date}  #{home_away}  #{win_loss}   #{other_team}"
      end
    end
  end
end
