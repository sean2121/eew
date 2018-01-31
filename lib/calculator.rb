require "pry"

module Calculator
include Math
  def shindo(latitude_s, longitude_s, latitude_e, longitude_e, mjwa, depth)
    max_speed(mjwa,distance(latitude_s, longitude_s, latitude_e, longitude_e),depth)
  end


  def distance(latitude_s, longitude_s, latitude_e, longitude_e)
    sin_lat_1 = sin(latitude_e * Math::PI / 180)
    cos_lat_1 = cos(latitude_e * Math::PI / 180)
    sin_lat_2 = sin(latitude_s * Math::PI / 180)
    cos_lat_2 = cos(latitude_s * Math::PI / 180)
    lamda1 = longitude_e * Math::PI / 180
    lamda2 = longitude_s * Math::PI / 180
    two_points_distance = 6370 * acos(sin_lat_1 * sin_lat_2 + cos_lat_1 * cos_lat_2 * cos(lamda1 - lamda2))
    l = uzu_formula
    two_points_distance - l
  end

  #宇津の公式を使って断層長を求めその値の半径をとる
  def uzu_formula
    magnitude = 8.4
    l = 10 ** (0.5 * magnitude - 1.85) 
    l / 2
  end 

  #Mjma-0.171
  def mjma2mw(mjma)
    mw = mjma - 0.171
  end

  def max_speed(mjma, distance, depth) 
    p mw = mjma2mw(mjma)
    p distance
    p log10(distance + 0.002810 ** (0.50 * mw))
    #p pgv600 = (0.58 * mw) + (0.0038 * depth) - 1.29 - log(distance + 0.002810 ** (0.50 * mw)) - 0.002 * distance
     #10 ** pgv600
    #log(PGV600)=0.58Mw+0.0038D-1.29-log(x+0.0028100.50Mw)-0.002x 
  end

  def max_acceration(distance)
    #magnitude =  8.5
    #log10A=0.41M-log10(R+0.032*10 ** 0.41M)-0.0034R+1.30
    #log10A=0.41M−log10(R+0.032⋅10 ** 0.41M)−0.0034R+1.30

    #log10(R+0.032*10 ** 0.41M)
    #temp = 0.41 * magnitude 
    #temp = 10 ** temp 
    #temp = 0.032 * temp
    #r2 = distance + temp
    #r2 = log10(r2)

    #r3 = 0.034 * distance  + 1.30
    #r1 = 0.41 * magnitude

    #p r1 - r2 - r3 
    #log10(r1 - r2 - r3)

  end

  def regression_analysis; end 
end
 

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