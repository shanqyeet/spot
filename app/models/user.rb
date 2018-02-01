require 'bcrypt'

class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :things
  has_many :authentications, dependent: :destroy
  has_many :thing_upvotes
  has_many :thing_downvotes
  has_many :shopping_items

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create


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

  # Remember Me

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


  # Custome Method
  def name
    first_name + ", " + last_name
  end

  def exp_calc
    case
    when level == 1
      min_exp = 0
      max_exp = 50
    when level == 2
      min_exp = 50
      max_exp = 150
    when level == 3
      min_exp = 150
      max_exp = 300
    when level == 4
      min_exp = 300
      max_exp = 500
    when level == 5
      min_exp = 500
      max_exp = 800
    when level == 6
      min_exp = 1200
      max_exp = 1200
    when level == 7
      min_exp = 1200
      max_exp = 1700
    when level == 8
      min_exp = 1700
      max_exp = 2500
    when level == 9
      min_exp = 2500
      max_exp = 3500
    else
      min_exp = 3500
      max_exp = 5000
    end
    actual = (exp-min_exp)/max_exp.to_f * 100
  end

  def check_level
    if self.exp_calc >= 100
      level + 1
    else
      level
    end
  end


end
