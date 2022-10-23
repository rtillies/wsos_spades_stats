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
    @home_score = row[3]
    @away_score = row[4]
  end

  def winning_team
    if !double_forfeit
      home_score > away_score ? home_code : away_code
    end
  end
  
  def differential
    abs(home_score-away_score)
  end

  def forfeit?
    differential == 1 && home_score < 2
  end

  def double_forfeit?
    differential == 0 && home_score == 0
  end
end