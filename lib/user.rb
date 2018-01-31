require './calculator.rb'
require "pry"

class User
include Calculator

  def initialize(latitude, longitude, id)
    @latitude_e = latitude
    @longitude_e = longitude
    @id = id
  end
  
  def calc(mailman)
     shindo = self.shindo(mailman.latitude_s, mailman.longitude_s, @latitude_e, @longitude_e, 8.4, 24)
  end
end