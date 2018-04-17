require 'nokogiri'
require 'open-uri'
require 'HTTParty'
require 'pry'

class Tomatoes

  def self.tomatoes
    doc = Nokogiri::HTML(open("https://www.swallowtailgardenseeds.com/veggies/heirloom.html"))


    @@seedsavers = HTTParty.get("https://www.seedsavers.org/category/tomato")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

  end

end #Tomatoes class
