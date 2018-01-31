require 'benchmark'
require 'pry'
require './user.rb'
require './mailman.rb'



# 地震の発生地点
latitude_s = 38.100000
longitude_s = 142.860000

# ユーザーの観測点
latitude = 38.543593
longitude = 141.133486

Mailman.new(latitude_s, longitude_s, User.new(latitude, longitude, 1))


