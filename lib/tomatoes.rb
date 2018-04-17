require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'pry'

class Tomatoes

  def scraper1
    # doc = Nokogiri::HTML(open("https://www.swallowtailgardenseeds.com/veggies/heirloom.html"))
    # doc.css(".https://www.swallowtailgardenseeds.com/veggies/heirloom.html").each do |tomato|
    # end
    @@seedsavers = HTTParty.get("https://www.seedsavers.org/amish-paste-tomato")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

    @@tomatoes.css(".item-details").each do |tomato|
      binding.pry
    end

  end

end #Tomatoes class
