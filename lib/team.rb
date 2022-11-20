require_relative 'game'
require_relative 'team'
require_relative 'division'

class Team
  attr_reader :code, :team_name, :conference, :division, :member1, :member2, :location
  attr_accessor :wins, :losses, :draw, :total_score, :opp_score,
                :hwins, :hloss, :awins, :aloss, :fwins, :floss, :double_forfeit,
                :dwins, :dloss, :cwins, :closs, :percentage
  
  def initialize(row)
    @code = row[0]
    @team_name = row[1]
    @conference = row[2]
    @division = row[3]
    @member1 = row[4]
    @member2 = row[5]
    @location = row[6]
    @wins = @losses = @draw = @double_forfeit = 0
    @total_score = @opp_score = 0
    @hwins = @hloss = @awins = @aloss = @fwins = @floss = 0
    @dwins = @dloss = @cwins = @closs = 0
  end

  def margin
    @total_score - @opp_score
  end

  def avg_margin
    played = wins + losses + draw - fwins - floss
    played > 0 ? (margin.to_f / played).round(1) : "n/a"
  end

  def forfeits 
    fwins + floss + double_forfeit
  end

  def percentage
    (wins.to_f / (wins + losses + draw + double_forfeit)).round(3)
  end
end