require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_many :things

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true #password_confirmation attr
  validates_length_of :password, in: 6..20, on: :create

  include BCrypt

  # 
  # def password
  #   @password ||= Password.new(password_hash)
  # end
  #
  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end
