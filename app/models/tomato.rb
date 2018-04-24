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

            the_details = []

            the_variety = tomato.css("a").children[0].text #for db
            content = tomato.css(".description").children.text

            split_words = content.split(" ")
            # days = split_words[0..1].join(" ") #for db

            split_content = content.split(".")
            split_content.delete("")
            split_content.delete("        read more")

            split_days = split_content[0].split(" ")
            days = split_days[0..1].join(" ")

            tomato_db = Tomato.find_by(variety: the_variety)

            unless tomato_db
              la_tomate = Tomato.new
              la_tomate.variety = the_variety
              la_tomate.days = days
              la_tomate.growth_type = split_words.find{ |word| word == "Semi-Indeterminate." || word == " Indeterminate" || word == "Indeterminate." || word == " Determinate" || word == "Ind." || word == "Ind" || word == "Det."}
              la_tomate.details = split_content.delete_if {|string|  string == " Semi-Indeterminate" || string == " Ind" || string == " Compact Ind" || string == " Indeterminate" || string == " Determinate" || string == " Vigorous Det" || string.include?("days")}
              la_tomate.save
            end
      end #each iterator, @@tomatoes
  end #scraper method


end #Tomatoes class
