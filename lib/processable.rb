module Processable
  def process_teams(team_list)
    # Process Teams
    contents = CSV.open team_list, headers: true, header_converters: :symbol

    contents.each do |row|
      team = Team.new(row)
      @teams[team.code] = team
    end
  
    puts("Team array counter:  #{@teams.size}")
  end
      
  def process_games(game_list)
    # Process Games
    contents = CSV.open game_list, headers: true, header_converters: :symbol

    contents.each do |row|
      game = Game.new(row)
      @games << game 

      home = game.home_code
      away = game.away_code
      d_game = game.div_game?
      c_game = game.conf_game?

      # Double Forfeit
      if game.double_forfeit?
        # puts "Double Forfeit Game ID: #{game.id}"
        @teams[home].no_contest += 1
        @teams[away].no_contest += 1
      else
        # Winner
        winner = game.winning_team
        loser = game.losing_team

        @teams[winner].wins += 1
        @teams[loser].losses += 1

        if d_game
          @teams[winner].dwins += 1
          @teams[loser].dloss += 1
        end

        if c_game
          @teams[winner].cwins += 1
          @teams[loser].closs += 1
        end

        # Home or Away Wins
        if home == winner
          @teams[winner].hwins += 1
          @teams[loser].hloss += 1
        else
          @teams[winner].awins += 1
          @teams[loser].aloss += 1
        end

        # Forfeit or Count Points
        if game.forfeit?
          @teams[winner].fwins += 1
          @teams[loser].floss += 1
        else
          @teams[winner].total_score += game.winning_score
          @teams[winner].opp_score += game.losing_score
          @teams[loser].total_score += game.losing_score
          @teams[loser].opp_score += game.winning_score
        end
      end
    end

    puts("Game array counter: #{@games.size}")
    teams.each do |c, t| 
      # require 'pry'; binding.pry
      # puts("Code: #{c}, Team: #{t.team_name}, Div: #{t.division}, Conf: #{t.conference}, Record #{t.wins}-#{t.losses}-#{t.no_contest} ")
    end

  end

  def process_divisions(div_list)
    # Process Divisions
    contents = CSV.open div_list, headers: true, header_converters: :symbol

    # puts("Divisions:")
    contents.each do |row|
      div = Division.new(row)
      @divisions << div
    end

    puts("Division array counter: #{@divisions.size}")
    
  end

  def process_output(output)
    div_output = Hash.new 

    @teams.each do |c, team| 
      if !div_output.has_key?(team.division)
        # puts "Add Division #{team.division}"
        div_output[team.division] = []
      end
      # puts "Add #{team} to #{team.division}"
      div_output[team.division] << team
    end

    headers = ["Team Name","Division","Conference","Wins","Loss","Percentage",
                "Total Score","Opp Score","Margin","Avg Margin",
                "Home Wins","Home Loss","Away Wins","Away Loss",
                "Div Wins","Div Loss","Conf Wins","Conf Loss",
                "Forf Wins","Forf Loss","Draw"]
    
    CSV.open(output, "w") do |csv|
      csv << headers
      blank_array = [""]
      div_array = ["None"]

      21.times do 
        blank_array << nil
        div_array << nil
      end

      # binding.pry
      last_div = div_array[0]
      div_output.each do |c, d| 
        this_div = c 
        if this_div != last_div
          div_array[0] = this_div.upcase
          csv << blank_array
          csv << div_array
        end

        d.each do |t|
          team_line = []
          team_line << t.team_name
          team_line << t.division
          team_line << t.conference
          team_line << t.wins
          team_line << t.losses
          team_line << t.percentage
          team_line << t.total_score
          team_line << t.opp_score
          team_line << t.differential
          team_line << t.avg_diff
          team_line << t.hwins
          team_line << t.hloss
          team_line << t.awins
          team_line << t.aloss
          team_line << t.dwins
          team_line << t.dloss
          team_line << t.cwins
          team_line << t.closs
          team_line << t.fwins
          team_line << t.floss
          team_line << t.no_contest
          
          csv << team_line
        end
      end
    end
  end
end