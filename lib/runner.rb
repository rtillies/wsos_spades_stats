# runner.rb
require './lib/stat_tracker'

week_number = ARGV[0]

game_path = "./data/Week#{week_number}CSV.csv"
out_div_path = "./data/outputDiv#{week_number}CSV.csv"
out_conf_path = "./data/outputDiv#{week_number}CSV.csv"

# game_path = './data/Week02CSV.csv'
# out_div_path  = './data/outputCSV.csv'
# out_conf_path = './data/outputCSV.csv'
team_path = './data/TeamCSV.csv'
div_path  = './data/DivisionCSV.csv'

locations = {
  teams:  team_path,
  games:  game_path,
  divs:   div_path,
  output: out_div_path
}

stat_tracker = StatTracker.from_csv(locations)