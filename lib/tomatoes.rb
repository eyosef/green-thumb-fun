require 'nokogiri'
require 'open-uri'
require 'HTTParty'
require 'pry'

class Tomatoes

  def tomato_scraper
    doc = Nokogiri::HTML(open("https://www.swallowtailgardenseeds.com/veggies/heirloom.html"))
    doc.css(".https://www.swallowtailgardenseeds.com/veggies/heirloom.html").each do |tomato|
      binding.pry
    end
    # @@seedsavers = HTTParty.get("https://www.seedsavers.org/category/tomato")
    # @@tomatoes = Nokogiri::HTML(@@seedsavers)

  end

end #Tomatoes class
