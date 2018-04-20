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

end #Tomatoes class
