require 'csv'
require_relative 'team'
require_relative 'game'
require_relative 'division'

class StatTracker
  attr_reader :teams, :games, :divisions
  
  def initialize(locations)
    @teams = []
    @games = []
    @divisions = []
    process_teams(locations[:teams])
    process_games(locations[:games])
    process_divisions(locations[:divs])
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def process_teams(team_list)
    # Process Teams
    contents = CSV.open team_list, headers: true, header_converters: :symbol

    contents.each do |row|
      team = Team.new(row)
      @teams << team 

      puts("Code: #{team.code}, Team: #{team.team_name}, Division: #{team.division}, Conference: #{team.conference}")
    end

    puts("Team array counter:  #{@teams.size}")
  end
    
  def process_games(game_list)
    # Process Games
    contents = CSV.open game_list, headers: true, header_converters: :symbol

    contents.each do |row|
      game = Game.new(row)
      @games << game 

      puts("Game ID: #{game.id}, Home: #{game.home_code} #{game.home_score}, Away: #{game.away_code} #{game.away_score}")
    end

    puts("Game array counter: #{@games.size}")
  end

  def process_divisions(div_list)
    # Process Divisions
    contents = CSV.open div_list, headers: true, header_converters: :symbol

    puts("Divisions:")
    contents.each do |row|
      div = Division.new(row)
      @divisions << div 

      puts("  #{div.code}: Division: #{div.division}, Conf: #{div.conference}")
    end

    puts("Division array counter: #{@divisions.size}")
    
  end
end
