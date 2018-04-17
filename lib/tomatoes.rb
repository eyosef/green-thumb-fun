require 'nokogiri'
require 'open-uri'
require 'HTTParty'
require 'pry'

class Tomatoes

  def self.tomatoes
    doc = Nokogiri::HTML(open("https://www.seedsavers.org/category/tomato"))

    @@seedsavers = HTTParty.get("https://www.seedsavers.org/category/tomato")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

  end

end #Tomatoes class
