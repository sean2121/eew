class Mailman

  attr_reader :latitude_s, :longitude_s, :mjma, :depth, :announce_time, :earthquake_time

  def initialize(latitude_s, longitude_s, mjma, depth , announce_time, earthquake_time)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @mjma = mjma
    @depth = depth
    @announce_time = announce_time
    @earthquake_time = earthquake_time
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