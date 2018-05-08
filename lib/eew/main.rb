require 'pry'
require './eew/user.rb'
require './eew/mailman.rb'
require './eew/parser.rb'
require './eew/traveltime.rb'
require 'dotenv/load'
require 'twitter'
require 'csv'

test = 'hound'


#観測値
latitude_e = 35.648554
longitude_e = 139.700882

Dotenv.load
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['ConsumerKey']
  config.consumer_secret     = ENV['ConsumerSecret']
end

loop do
  #begin
  client.user_timeline('eewbot', count: 1 ).each do |tweet|
    if tweet.id != @id
      threads_mutex = Mutex.new
      threads_mutex.synchronize do
      eew = Parser.new(tweet.full_text).parse
      p eew
      latitude_s, longitude_s, mjma, depth, announce_time, earthquake_time = eew[:latitude_s], eew[:longitude_s], eew[:mjma], eew[:depth], eew[:announce_time], eew[:earthquake_time]
      earthquake = Mailman.new(latitude_s.to_f, longitude_s.to_f, mjma.to_f, depth.to_f, announce_time, earthquake_time)
      earthquake.add_user(User.new(latitude_e, longitude_e, 1))
      earthquake.notify_to_user
      end
    end
  @id = tweet.id
  end
  #rescue => ex
  #  puts ex.message
  #end
  sleep(2)
end



=begin
電文の種別

35：最大震度のみ。Mの推定なし

36、37：最大震度、Mの推定あり

39：キャンセル

訓練識別符

00：通常

01：訓練

発表状況

0：通常

7：キャンセルを誤って発表したとき（地震ID以降の項目は空）

8,9：最終報

電文番号

地震IDごとに00-99

震源海陸判定

0：陸

1：海

警報の有無

0：警報なし。予報。M3.5以上と推定、もしくは地震計で100ガル以上の加速度を検知した時発表。小さな地震でも発表。

1：警報あり。一般向けEEWが発表されている。テレビとかで出てるやつ。

=end



