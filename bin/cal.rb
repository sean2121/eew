require 'benchmark'
require 'pry'
include Math
include './Calculator'


class Mailman
  attr_reader :latitude_s, :longitude_s
  def initialize(latitude_s, longitude_s, user)
    @latitude_s = latitude_s
    @longitude_s = longitude_s
    @user = user
    @user.update(self)
  end
end

class User
  def initialize(latitude, longitude, id)
    @latitude_e = latitude
    @longitude_e = longitude
    @id = id
  end

  def update(mailman)
    Calculator.distance(mailman.latitude_s, mailman.longitude_s)
  end
end

#震源地
latitude_s = 33.590354700000
longitude_s = 130.401715500000
#観測値
latitude = 35.501132600000
longitude = 134.235091400000

magnitude = 8.0

Mailman.new(latitude_s, longitude_s, User.new(latitude, longitude, 1))



# L= 6370 arccos(sinφ1sinφ2+cosφ1cosφ2cos(λ1−λ2))
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
