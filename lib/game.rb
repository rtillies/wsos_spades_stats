require_relative 'game'
require_relative 'team'
require_relative 'division'
require 'Date'

class Game
  attr_reader :id,
              :date,
              :home_code,
              :away_code,
              :home_score,
              :away_score
  
  def initialize(row)
    @id = row[0]
    @date = row[1]
    @home_code = row[2]
    @away_code = row[3]
    @home_score = row[4].to_i
    @away_score = row[5].to_i
  end

  def winning_team
    if !double_forfeit?
      home_score > away_score ? home_code : away_code
    end
  end
  
  def losing_team
    if !double_forfeit?
      home_score < away_score ? home_code : away_code
    end
  end

  def winning_score
    [home_score, away_score].max
  end
  
  def losing_score
    [home_score, away_score].min
  end
  
  def differential
    (home_score.to_i - away_score.to_i).abs
  end

  def forfeit?
    differential == 1 && home_score < 2
  end

  def double_forfeit?
    differential == 0 && home_score == 0
  end

  def conf_game?
    div_game? ? true : get_conf(home_code) == get_conf(away_code)
  end

  def get_conf(team)
    t0 = team[0] 
    (t0 == 'A' || t0 == 'B' || t0 == 'C') ? 'W' : 'E'
end 

  def div_game?
    home_code[0] == away_code[0]
  end
end