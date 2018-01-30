class Thing < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :users, through: :thing_upvotes
  has_many :users, through: :thing_downvotes

  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def full_address
    [address, city, state, country].compact.join(',')
  end
end
