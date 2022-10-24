# runner.rb
require './lib/stat_tracker'

game_path = './data/GameCSV.csv'
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