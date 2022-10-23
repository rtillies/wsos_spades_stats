# runner.rb
require './lib/stat_tracker'

game_path = '../data/GameCSV.csv'
team_path = './data/TeamCSV.csv'
div_path  = '../data/DivisionCSV.csv'

locations = {
  teams: team_path,
  games: game_path,
  divs:  div_path
}

# stat_tracker = StatTracker.new(locations)
stat_tracker = StatTracker.from_csv(locations)

# require 'pry'; binding.pry