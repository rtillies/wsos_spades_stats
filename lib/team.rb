class Team
  attr_reader :code,
              :team_name,
              :conference,
              :division,
              :member1,
              :member2,
              :location
  
  def initialize(row)
    @code = row[0]
    @team_name = row[1]
    @conference = row[2]
    @division = row[3]
    @member1 = row[4]
    @member2 = row[5]
    @location = row[6]
  end
end