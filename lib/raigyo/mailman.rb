class Mailman

  attr_reader :latitude_s, :longitude_s, :mjma, :depth

  def initialize(latitude_s, longitude_s, mjma, depth, user)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @mjma = mjma
    @depth = depth
    @user = user
    calc
  end

  def calc
    @user.calc(self)
  end 

  
  private  
  def alert
    @user.alert(self)
  end
end