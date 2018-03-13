class Mailman

  attr_reader :latitude_s, :longitude_s, :mjma, :depth

  def initialize(latitude_s, longitude_s, mjma, depth)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @mjma = mjma
    @depth = depth
    @users = []
  end

  def notify_to_user
    @users.each do |user|
      user.update(self)
    end
  end 

  def add_user(user)
    @users << user 
  end 

  def delete_user(user)
    @users.delete(user)
  end
  
  private  
  def alert
    @user.alert(self)
  end
end