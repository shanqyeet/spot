require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_many :things
  has_many :authentications, dependent: :destroy
  has_many :things, through: :thing_upvotes
  has_many :things, through: :thing_downvotes
  has_many :shopping_items

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

  def name
    first_name + ", " + last_name
  end

  def exp_calc
    case
    when level == 1
      max_exp = 50
    when level == 2
      max_exp = 150
    when level == 3
      max_exp = 300
    when level == 4
      max_exp = 500
    when level == 5
      max_exp = 800
    when level == 6
      max_exp = 1200
    when level == 7
      max_exp = 1700
    when level == 8
      max_exp = 2500
    when level == 9
      max_exp = 3500
    else
      max_exp = 5000
    end
    actual = exp/max_exp.to_f * 100
  end
end
