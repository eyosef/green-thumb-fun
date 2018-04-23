class User < ActiveRecord::Base

  has_many :tomatoes
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true

  validates :password, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(slug)
    all_users = User.all
    user = all_users.find do |user|
              user.slug == slug
            end

    return user
  end

end
