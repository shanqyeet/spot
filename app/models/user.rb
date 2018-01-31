require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_many :things
  has_many :authentications, dependent: :destroy
  has_many :things, through: :thing_upvotes
  has_many :things, through: :thing_downvotes

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true #password_confirmation attr
  # validates_length_of :password, in: 6..30, on: :create

  include BCrypt

  def self.create_with_auth_and_hash(authentication, auth_hash)
     user = self.create!(
      first_name: auth_hash["extra"]["raw_info"]["name"],
       email: auth_hash["extra"]["raw_info"]["email"],
       # remote_avatar_url: auth_hash["info"]["image"],
       password: SecureRandom.hex(16)
     )
     user.authentications << authentication
     return user
  end

  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end
end
