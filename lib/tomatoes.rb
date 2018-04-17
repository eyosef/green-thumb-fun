require 'nokogiri'
require 'HTTParty'
require 'pry'

class Tomatoes

  def self.tomatoes
    binding.pry
    @@seedsavers = HTTParty.get("https://www.seedsavers.org/category/tomato")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

  end

end #Tomatoes class
