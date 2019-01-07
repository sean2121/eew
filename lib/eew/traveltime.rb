require 'csv'

class Traveltime
  def initialize(file_name)
    @readings = []
    CSV.foreach(file_name, headers: false) do |row|
      @readings << {
        p_wave: row[0],
        psec: row[1],
        s_wave: row[2],
        ssec: row[3],
        depth: row[4],
        distance: row[5]
      }
    end
  end

  def time_estimate(depth, shortest_distance)
    depth = convert(depth)
    shortest_distance = convert(shortest_distance)
    @readings.find { |item| item[:depth] == depth.to_s && item[:distance] == shortest_distance.to_s }&.fetch_values(:psec, :ssec)
  end


  #文字を丸めた後に変換する
  #depth 200km以降は10区切り,50kmまでは5区切りそれ以前は2区切り
  #shortest_distancekmは50以降は5区切り、それ以前は2
  def convert(number)
    number = number.round
    if number > 200
      number - number % 10
    elsif number > 50
      number - number % 5
    else
      number - number % 2
    end
  end
end 