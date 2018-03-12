require './eew/calculator.rb'
require "pry"

class User
include EEW::Calculator

  def initialize(latitude, longitude, id)
    @latitude_e = latitude
    @longitude_e = longitude
    @id = id
  end
  
  def calc(mailman)
    self.shindo(mailman.latitude_s, mailman.longitude_s, mailman.mjma, mailman.depth, @latitude_e, @longitude_e)
  end
end