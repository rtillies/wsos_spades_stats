require_relative 'game'
require_relative 'team'
require_relative 'division'

class Team
  attr_reader :code, :team_name, :conference, :division, :member1, :member2, :location,
              :wins, :losses, :no_contest, :total_score, :opp_score,
              :hwins, :hloss, :awins, :alosses, :fwins, :flosses
  
  def initialize(row)
    @code = row[0]
    @team_name = row[1]
    @conference = row[2]
    @division = row[3]
    @member1 = row[4]
    @member2 = row[5]
    @location = row[6]
  end

  def increment(stat)
    stat += 1
  end

  def increase(stat, amount)
    stat += amount
  end
end