require 'benchmark'
require 'pry'
require './raigyo/user.rb'
require './raigyo/mailman.rb'
require 'dotenv/load'
require "twitter"


Dotenv.load
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['ConsumerKey']
  config.consumer_secret     = ENV['ConsumerSecret']
end

Thread.start{
  loop do 
    client.user_timeline('eewbot', count: 1 ).each do |tweet|
     p tweet.text
    end
  end 
}

  loop do 
    puts "hello"
    sleep 0.5
  end

#発生地
latitude_s = 38.4385
longitude_s = 141.3016

#観測値
latitude_e = 38.103335
longitude_e = 142.864177

depth = 24
mjma = 8.4

Mailman.new(latitude_s, longitude_s, mjma, depth, User.new(latitude_e, longitude_e, 1))


