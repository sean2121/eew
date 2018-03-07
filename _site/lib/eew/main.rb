require 'pry'
require 'user.rb'
require 'mailman.rb'
require 'parser.rb'
require 'dotenv/load'
require 'twitter'
require 'csv'

#観測値
latitude_e = 24.234869
longitude_e = 123.700470

Dotenv.load
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['ConsumerKey']
  config.consumer_secret     = ENV['ConsumerSecret']
end

#client.user_timeline('eewbot', count: 1 ).each do |tweet|
# 
#  end
#end

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

loop do 
  client.user_timeline('eewbot', count: 1 ).each do |tweet|
     if tweet.id != @id 
       Thread.new{
          eew = Parser.new(tweet.full_text).parse
          if eew[:test] != 0
            latitude_s, longitude_s, mjma, depth = eew[:latitude_s], eew[:longitude_s], eew[:mjma], eew[:depth]
            p eew[:latitude_s]
          p eew[:longitude_s]
          p eew[:mjma]
          p eew[:depth]
          p eew[:region]
          p Mailman.new(latitude_s.to_f, longitude_s.to_f, mjma.to_f, depth.to_f, User.new(latitude_e, longitude_e, 1))
        end
        }
      end
      @id = tweet.id
       5.times{puts "hi"}
  end
end

  

=begin
fiber = Fiber.new do 
  loop do 
    p @id
    client.user_timeline('eewbot', count: 1 ).each do |tweet|
       if tweet.id.equal?(@id)
         Fiber.yield
       else
         @id = tweet.id
         puts "hello"
       end
    end
  end 
end 

loop do 
 fiber.resume
end 

def my_func
  3.times{"hello"}
end
=end



#発生地


#Mailman.new(latitude_s, longitude_s, mjma, depth, User.new(latitude_e, longitude_e, 1))