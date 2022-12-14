require 'csv'
require 'pry'
require_relative 'team'
require_relative 'game'
require_relative 'division'

class StatTracker
  attr_reader :teams, :games, :divisions, :output
  
  def initialize(locations)
    @teams = Hash.new
    @games = []
    @divisions = []
    process_teams(locations[:teams])
    process_games(locations[:games])
    process_divisions(locations[:divs])
    process_output(locations[:output])
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def process_teams(team_list)
    # Process Teams
    contents = CSV.open team_list, headers: true, header_converters: :symbol

    contents.each do |row|
      team = Team.new(row)
      @teams[team.code] = team

      # puts("Code: #{team.code}, Team: #{team.team_name}, Division: #{team.division}, Conference: #{team.conference}")
      @teams.each do |c, t| 
        # require 'pry'; binding.pry
        # puts("Code: #{c}, Team: #{t.team_name}, Division: #{t.division}, Conference: #{t.conference}")
      end
    end

    puts("Team array counter:  #{@teams.size}")
  end
    
  def process_games(game_list)
    # Process Games
    contents = CSV.open game_list, headers: true, header_converters: :symbol

    contents.each do |row|
      game = Game.new(row)
      @games << game 

      # puts("Game ID: #{game.id}, Home: #{game.home_code} #{game.home_score}, Away: #{game.away_code} #{game.away_score}")

      home = game.home_code
      away = game.away_code
      d_game = game.div_game?
      c_game = game.conf_game?

      # Double Forfeit
      if game.double_forfeit?
        puts "Double Forfeit Game ID: #{game.id}"
        @teams[home].no_contest += 1
        @teams[away].no_contest += 1
        # puts("Game ID: #{game.id}, Home: #{game.home_code} #{game.home_score}, Away: #{game.away_code} #{game.away_score}")
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

      # Forfeit
      # if game.forfeit?
      #   winner = game.winning_team
      #   loser = game.losing_team

      #   puts "Forfeit Game ID: #{game.id}"
      # end
      # @teams[home].total_score += game.home_score

    end

    puts("Game array counter: #{@games.size}")
    teams.each do |c, t| 
      # require 'pry'; binding.pry
      puts("Code: #{c}, Team: #{t.team_name}, Div: #{t.division}, Conf: #{t.conference}, Record #{t.wins}-#{t.losses}-#{t.no_contest} ")
    end

  end

  def process_divisions(div_list)
    # Process Divisions
    contents = CSV.open div_list, headers: true, header_converters: :symbol

    puts("Divisions:")
    contents.each do |row|
      div = Division.new(row)
      @divisions << div




      # puts("  #{div.code}: Division: #{div.division}, Conf: #{div.conference}")
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

    # puts " #{t.team_name} #{t.wins}-#{t.losses}-#{t.no_contest}, Points: #{t.total_score} Against: #{t.opp_score}"
    # puts " #{t.team_name} #{t.wins}-#{t.losses}-#{t.no_contest}, Forfeits: #{t.forfeits},  Avg Diff: #{t.avg_diff}"
    # puts("Code: #{c}, Division: #{d.division}, Conference: #{d.conference}")
    
    #films_info is an array of arrays
    # headers = ["Rank", "Title", "Genre", "Description", "Director", "Actors", "Year", "Runtime (Minutes)", "Rating", "Votes", "Revenue (Millions)", "Metascore"]
    headers = ["Team Name","Division","Conference","Wins","Loss","No Contest","Total Score","Opp Score",
               "Differential","Avg Diff","Home Wins","Home Loss","Away Wins","Away Loss",
               "Div Wins","Div Loss","Conf Wins","Conf Loss","Forf Wins","Forf Loss"]
    
    CSV.open(output, "w") do |csv|
      csv << headers
      blank_array = [""]
      div_array = ["None"]

      20.times do 
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
          team_line << t.no_contest
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
          
          csv << team_line
        end

      end
    end
  end
end
