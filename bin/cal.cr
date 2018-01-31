class Mailman
  getter :latitude_s, :longitude_s
  def initialize(latitude_s : Float64 , longitude_s : Float64, user)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @user = user
    @user.update(self)
  end
end

class User(T)
  def initialize(latitude : Float64 , longitude : Float64, id : Int32)
    @latitude_e = latitude
    @longitude_e = longitude
    @id = id
  end

  def update(mailman)
    distance(mailman.latitude_s, mailman.longitude_s)
  end
end


def distance(latitude_s : Float64 , longitude_s : Float64)
  sin_lat_1 = sin(@latitude_e * Math::PI / 180)
  cos_lat_1 = cos(@latitude_e * Math::PI / 180)
  sin_lat_2 = sin(latitude_s * Math::PI / 180)
  cos_lat_2 = cos(latitude_s * Math::PI / 180)
  lamda1 = @longitude_e * Math::PI / 180
  lamda2 = longitude_s * Math::PI / 180
  distance = 6370 * acos(sin_lat_1 * sin_lat_2 + cos_lat_1 * cos_lat_2 * cos(lamda1 - lamda2))
  p distance
end

def max_speed; end

def max_acceration; end

latitude_s = 33.590354700000
longitude_s = 130.401715500000

latitude = 35.501132600000
longitude = 134.235091400000

100.times do
  Mailman.new(latitude_s, longitude_s, User.new(latitude,longitude,1))
end

#  L= 6370 arccos(sinφ1sinφ2+cosφ1cosφ2cos(λ1−λ2))
# logA=b-log( X+c )-kX
# A=速度最大値
# X=断層最短距離[km](ここでは震源距離 R を使用)
# k=係数 0.002
# c=0.0028*100.50mw
# b= aMw + hD +Σ diSi + e + ε
# a=0.55 Mw=マグニチュード
# h=0.0037
# D=震源深さ
# ΣdiSi=0.01
# e=-1.10
# ε= 0
