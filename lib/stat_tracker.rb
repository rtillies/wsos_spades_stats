require 'csv'
require_relative 'team'

class StatTracker
  attr_reader :teams, :games, :divisions
  
  def initialize(locations)
    @teams = []
    process_teams(locations[:teams])
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def process_teams(team_list)
    # Process Teams
    # puts teams
    contents = CSV.open team_list, headers: true, header_converters: :symbol
    team_count = 0

    contents.each do |row|
      # code = row[:code]
      # team_name = row[:teamname]
      # conference = row[:conference]
      # division = row[:division]
      # member1 = row[:member1]
      # member2 = row[:member2]
      # location = row[:location]

      # puts("Code: #{code}, Team: #{team_name}, Division: #{division}, Conference: #{conference}")
      # team_count += 1
      
      team = Team.new(row)
      @teams << team 

      puts("Code: #{team.code}, Team: #{team.team_name}, Division: #{team.division}, Conference: #{team.conference}")
      # puts ""
      
    end

    # puts("Team count variable: #{team_count}")
    puts("Team array counter:  #{@teams.size}")
  end
    
    def process_games
    end

    def process_divisions
    end
end

# # Process Games
# contents = CSV.open '../data/GameCSV.csv', headers: true, header_converters: :symbol
# game_count = 0

# contents.each do |row|
#   code = row[:code]
#   team_name = row[:teamname]
#   conference = row[:conference]
#   division = row[:division]
#   member1 = row[:member1]
#   member2 = row[:member2]
#   location = row[:location]

#   puts("Code: #{code}, Team: #{team_name}, Division: #{division}, Conference: #{conference}")
#   team_count += 1
# end

# puts("  Teams: #{team_count}")

# contents = CSV.open '../data/TeamCSV.csv', headers: true, header_converters: :symbol
# team_count = 0

# contents.each do |row|
#   code = row[:code]
#   team_name = row[:teamname]
#   conference = row[:conference]
#   division = row[:division]
#   member1 = row[:member1]
#   member2 = row[:member2]
#   location = row[:location]

#   puts("Code: #{code}, Team: #{team_name}, Division: #{division}, Conference: #{conference}")
#   team_count += 1
# end

# puts("  Teams: #{team_count}")
