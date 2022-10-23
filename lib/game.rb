require_relative 'team'

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

  def home_team
    
  end

  def away_team
  end
end