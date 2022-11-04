# runner.rb
require './lib/stat_tracker'

week_number = ARGV[0]
game_path = "./data/Week#{week_number}CSV.csv"
puts game_path 

# game_path = './data/Week02CSV.csv'
team_path = './data/TeamCSV.csv'
div_path  = './data/DivisionCSV.csv'
out_path  = './data/outputCSV.csv'

locations = {
  teams:  team_path,
  games:  game_path,
  divs:   div_path,
  output: out_path
}

stat_tracker = StatTracker.from_csv(locations)