require 'pry'

class Parser 
  class Error < StandardError; end
  def initialize(row)
    raise ArgumentError unless row.kind_of?(String)
    CSV.parse(row) do |i|
      @row_csv = i.map(&:freeze).freeze 
    end
    raise Error, "Incorrect Format" if @row_csv.size > 16
  end

  #1.電文の種別,
  #2.訓練識別符,
  #3.発表時刻,
  #4.発表状況,
  #5.電文番号,
  #6.地震ID,
  #7.地震発生時刻,
  #8.震源の北緯,
  #9.震源の東経,
  #10.震央地名,
  #11.震源の深さ,
  #12.マグニチュード(以下M),
  #13.最大震度,
  #14.震源の海陸判定,
  #15.警報の有無
 

  def parse()
    #["37", "00", "2018/03/02 03:20:28", "9", "3", "ND20180302031944", "2018/03/02 03:19:35", "42.5", "143.6", "十勝沖", "50", "3.5", "2", "1", "0"]
    token = [
      :type, :test, :announce_time, :situation, 
      :number, :earthquake_id, :earthquake_time, :latitude_s, :longitude_s,
      :region, :depth, :mjma, :max_shindo, :land_sea, :continues 
    ].freeze
    Hash[token.zip @row_csv]
  end
end 


