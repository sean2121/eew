require 'csv'
class Traveltime
  Reading = Struct.new( :psec, :s_wave, :ssec, :depth, :distance) 
  
  def initialize(file_name)
    @readings = []
    CSV.foreach(file_name, headers:false) do |row|
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
    p depth = convert(depth)
    p shortest_distance = convert(shortest_distance)
    binding.pry
  end 
  

  #文字を丸めた後に変換する
  #depth 50km以降は5区切りそれ以前は2
  #shortest_distancekmは50以降は5区切り、それ以前は2
  def convert(number)
    number = number.round 
    if number < 50
      number - number % 2
    else 
      number - number % 5 
    end
  end
end 