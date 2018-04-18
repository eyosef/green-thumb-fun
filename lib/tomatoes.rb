require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'pry'

class Tomatoes

  attr_accessor :variety, :days, :growth_type, :details

  @@all = []

  def initialize
    @variety = variety
    @days = days
    @growth_type = growth_type
    @details = details
  end

  def scraper
    # doc = Nokogiri::HTML(open("https://www.swallowtailgardenseeds.com/veggies/heirloom.html"))
    # doc.css(".https://www.swallowtailgardenseeds.com/veggies/heirloom.html").each do |tomato|
    # end
    @@seedsavers = HTTParty.get("https://www.fedcoseeds.com/seeds/?cat=Tomatoes")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

      @@tomatoes.css(".search-results-text").each do |tomato|

          @the_details = []

            @the_variety = tomato.css("a").children[0].text #for db
            content = tomato.css(".description").children.text

            split_words = content.split(" ")
            # days = split_words[0..1].join(" ") #for db

            split_content = content.split(".")
            split_content.delete("")
            split_content.delete("        read more")

            split_content.each do |string|

                if string == " Indeterminate" || string == " Determinate"
                    @the_growth_type = string #FOR DB
                    #making variable instance variable to call on it outside of the each iterator
                elsif !string.include?("days") && !string.include?(" Ind") && !string.include?(" Compact Ind") && !string.include?(" “If only")
                  @the_details << string #FOR DB
                elsif string.include?("days")
                  array = []
                  split_string = string.split(" ")
                  days = split_string[0..1].join(" ")
                  @the_days = days #FOR DB
                end #if statement
                tomato = Tomatoes.new
                tomato.days = @the_days
                tomato.growth_type = @the_growth_type
                tomato.details = @the_details
                tomato.variety = @the_variety
                @@all << tomato
            end #each iteration, split_content
      end #each iterator, @@tomatoes

  end #scraper method

end #Tomatoes class
