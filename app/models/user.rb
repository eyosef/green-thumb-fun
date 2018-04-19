class User < ActiveRecord::Base

  has_many :tomatoes
  has_secure_password

end
