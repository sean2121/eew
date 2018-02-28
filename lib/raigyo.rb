require 'benchmark'
require 'pry'
require './raigyo/user.rb'
require './raigyo/mailman.rb'
require 'dotenv/load'



#発生地
latitude_s = 38.4385
longitude_s = 141.3016

#観測値
latitude_e = 38.103335
longitude_e = 142.864177

depth = 24
mjma = 8.4

p ENV['S3_BUCKET']

Mailman.new(latitude_s, longitude_s, mjma, depth, User.new(latitude_e, longitude_e, 1))


