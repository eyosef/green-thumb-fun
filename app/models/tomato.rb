class Tomato < ActiveRecord::Base
  belongs_to :users

  def slug
    self.variety.split(" ").join("-").downcase
  end

  def self.find_by_slug(slug)
    all_tomatoes = Tomato.all
    tomato = all_tomatoes.find do |tomato|
              tomato.slug == slug
            end

    return tomato
  end

  def self.scraper
    seedsavers = HTTParty.get("https://www.fedcoseeds.com/seeds/?cat=Tomatoes")
    tomatoes = Nokogiri::HTML(seedsavers)

      tomatoes.css(".search-results-text").each do |tomato|

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
