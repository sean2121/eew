module EEW
  module Calculator
    include Math
    #PGVから求めた震度を返す。

    #IINSTR =2.68+1.72log(PGV)(4<IINSTR<7)
    def shindo(latitude_s, longitude_s, mjma, depth, latitude_e, longitude_e, announce_time, earthquake_time)
      d = two_points_distance(latitude_s, longitude_s, latitude_e, longitude_e, depth)
      mw = mjma_to_mw(mjma)
      fl = falut_length(mw)
      shortest_distance = d - fl
      pgv700 = max_speed(shortest_distance, depth, mw)
      iinstr = 2.68 + 1.72 * log10(pgv700)
      return iinstr, window_time(depth, shortest_distance, announce_time, earthquake_time)
    end

    # 猶予時間 = N-(B-A)-C
    # N= 地震到達所要時間
    # A= 地震発生時刻
    # B= 電文の発表時刻
    # C= 通信および計算定数
    #走時表
    def window_time(depth, shortest_distance, announce_time, earthquake_time)
      readings = Traveltime.new('test.csv')
      taple = readings.time_estimate(depth, shortest_distance)
      taple[0].to_i - (Time.parse(announce_time) - Time.parse(earthquake_time))
    end

    #2点間の距離を返す。
    #R^2=D^2+(k*(Ax-Bx))^2+(k*(Ay-By))^2
    def two_points_distance(latitude_s, longitude_s, latitude_e, longitude_e, depth)
      k = 111.32
      distance = Math.sqrt(((depth ** 2) + (k * (latitude_s - latitude_e)) ** 2 + (k * (longitude_s - longitude_e)) ** 2))
      return distance
    end

    #気象庁マグニチュードからモーメントマグニチュードに変換した値を返す。
    def mjma_to_mw(mjma)
      #mw = (mjma - 0.171)
      return mjma
    end


    #断層長
    def falut_length(mw)
      diameter = 10 ** (0.5 * mw - 1.85)
      diameter /= 2
      if diameter < 3
        diameter = 3
      end
      return diameter
    end

    #最大速度を求める工学的基盤面(PGV700)を返す。
    #log(PGV600)=0.58Mw+0.0038D-1.29-log(x+0.002810^0.50Mw)-0.002 x
    #(m/s)
    def max_speed(shortest_distance, depth, mw)
      log_pgv600 = (0.58 * mw) + (0.0038 * depth) - 1.29 - log10(shortest_distance + 0.002810 ** (0.50 * mw)) - 0.002 * shortest_distance
      pgv600 = 10 ** log_pgv600
      pgv700 = pgv600 * 0.9
      return pgv700
    end


    def amplification(pgv)
      return(pgv * 2.25853)
    end


    #球面三角法を用いた2点間距離を求める。
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
  end
end
