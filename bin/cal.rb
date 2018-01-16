require 'benchmark'
require 'pry'
include Math


#
class Mailman
  attr_reader :latitude_s, :longitude_s
  def initialize(latitude_s, longitude_s, user)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @user = user
    @user.update(self)
  end
end

# 
class User 
  def initialize(latitude, longitude, id)
    @latitude_e = latitude
    @longitude_e = longitude
    @id = id
  end
end

#
def update(mailman)
    distance(mailman.latitude_s, mailman.longitude_s)
end

#
def distance(latitude_s, longitude_s)
  sin_lat_1 = sin(@latitude_e * Math::PI / 180)
  cos_lat_1 = cos(@latitude_e * Math::PI / 180)
  sin_lat_2 = sin(latitude_s * Math::PI / 180)
  cos_lat_2 = cos(latitude_s * Math::PI / 180)
  lamda1 = @longitude_e * Math::PI / 180
  lamda2 = longitude_s * Math::PI / 180
  distance = 6370 * acos(sin_lat_1*sin_lat_2+cos_lat_1*cos_lat_2*cos(lamda1-lamda2))
  p distance 
end

latitude_s = 33.590354700000
longitude_s = 130.401715500000

latitude = 35.501132600000
longitude = 134.235091400000

100.times do
  user = User.new(latitude, longitude, 1)
  Mailman.new(latitude_s, longitude_s, user)
end

#  L = 6370 arccos(sinφ1sinφ2+cosφ1cosφ2cos(λ1−λ2))