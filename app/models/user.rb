class User < ActiveRecord::Base
  before_save {self.email = email.downcase}

  before_save {
    name_arr = name.split(" ").map {|name| name.capitalize }
    self.name = name_arr.join(" ")
  }

  validates :name, length: {minimum: 1, maximum: 100}, presence: true

  validates :password, length: {minimum: 6}, presence: true, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  validates :email, length: {minimum: 3, maximum: 254}, presence: true,
            uniqueness: {case_sensitive: false}

  has_secure_password
end
