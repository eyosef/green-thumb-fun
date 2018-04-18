require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'pry'

class Tomato < ActiveRecord::Base
  belongs_to :users

  def scraper1
    # doc = Nokogiri::HTML(open("https://www.swallowtailgardenseeds.com/veggies/heirloom.html"))
    # doc.css(".https://www.swallowtailgardenseeds.com/veggies/heirloom.html").each do |tomato|
    # end
    @@seedsavers = HTTParty.get("https://www.fedcoseeds.com/seeds/?cat=Tomatoes")
    @@tomatoes = Nokogiri::HTML(@@seedsavers)

      @@tomatoes.css(".search-results-text").each do |tomato|

          @details = []


            variety = tomato.css("a").children[0].text #for db
            content = tomato.css(".description").children.text

            split_words = content.split(" ")
            # days = split_words[0..1].join(" ") #for db

            split_content = content.split(".")
            split_content.delete("")
            split_content.delete("        read more")

            split_content.each do |string|
                if string == " Indeterminate" || string == " Determinate"
                    @growth_type = string #FOR DB
                    #making variable instance variable to call on it outside of the each iterator
                elsif !string.include?("days") && !string.include?(" Ind") && !string.include?(" Compact Ind") && !string.include?(" “If only")
                  @details << string #FOR DB
                elsif string.include?("days")
                  array = []
                  split_string = string.split(" ")
                  days = split_string[0..1].join(" ")
                  @days = days #FOR DB
                end #if statement
            end #each iteration, split_content
            binding.pry
      end #each iterator, @@tomatoes
  end #scraper method

end #Tomatoes class
