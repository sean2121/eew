require 'pry'

class Eewparser 
  class Error < StandardError; end
  def initialize(row)
    raise ArgumentError unless row.kind_of?(String)
    CSV.parse(row) do |i|
      @row_csv = i.map(&:freeze).freeze 
    end
    raise Error, "Incorrect Format" if @row_csv.size > 16
  end

  #電文の種別,訓練識別符,発表時刻,発表状況,電文番号,地震ID,地震発生時刻,震源の北緯,震源の東経,震央地名,震源の深さ,マグニチュード(以下M),最大震度,震源の海陸判定,警報の有無o
 

  def parse()
    #["37", "00", "2018/03/02 03:20:28", "9", "3", "ND20180302031944", "2018/03/02 03:19:35", "42.5", "143.6", "十勝沖", "50", "3.5", "2", "1", "0"]
    token = [
      :type, :practice, :announce_time, :situation, 
      :number, :earthquake_id, :earthquake_time, :latitude_s, :longitude_s,
      :depth, :mw, :max_shindo, :land_sea, :continues 
    ].freeze
    Hash[token.zip @row_csv]
  end
end 


