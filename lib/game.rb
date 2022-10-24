require_relative 'game'
require_relative 'team'
require_relative 'division'

class Game
  attr_reader :id,
              :home_code,
              :away_code,
              :home_score,
              :away_score
  
  def initialize(row)
    @id = row[0]
    @home_code = row[1]
    @away_code = row[2]
    @home_score = row[3].to_i
    @away_score = row[4].to_i
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
    if div_game?
      return true
    else
      if home_code[0] == 'A' || home_code[0] == 'B' || home_code[0] == 'C'
        home_conf = 'W'
      else
        home_conf = 'E'
      end
      if away_code[0] == 'A' || away_code[0] == 'B' || away_code[0] == 'C'
        away_conf = 'W'
      else
        away_conf = 'E'
      end
      return home_conf == away_conf
    end
  end

  def div_game?
    home_code[0] == away_code[0]
  end
end