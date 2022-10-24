require_relative 'game'
require_relative 'team'
require_relative 'division'

class Team
  attr_reader :code, :team_name, :conference, :division, :member1, :member2, :location
  attr_accessor :wins, :losses, :no_contest, :total_score, :opp_score,
                :hwins, :hloss, :awins, :aloss, :fwins, :floss,
                :dwins, :dloss, :cwins, :closs
  
  def initialize(row)
    @code = row[0]
    @team_name = row[1]
    @conference = row[2]
    @division = row[3]
    @member1 = row[4]
    @member2 = row[5]
    @location = row[6]
    @wins = @losses = @no_contest = @total_score = @opp_score = 0
    @hwins = @hloss = @awins = @aloss = @fwins = @floss = 0
    @dwins = @dloss = @cwins = @closs = 0
  end

  def increment(stat)
    stat += 1
  end

  def increase(stat, amount)
    stat += amount
  end
end