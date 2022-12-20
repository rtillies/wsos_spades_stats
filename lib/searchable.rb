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
    team = find_by_name(team_stub)
    # puts "Team name: #{team.team_name}"
    # team
  end

  def show_games(team)
    code = team.code
    name = team.team_name
    wins = team.wins
    losses = team.losses
    conf = team.conference
    div = team.division

    puts "#{name} (#{wins}-#{losses})"
    puts "#{conf} | #{div}"

    @games.each do |game|
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
