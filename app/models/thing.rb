class Thing < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :thing_upvotes
  has_many :thing_downvotes

  validates :name, presence: true
  validates :currency, presence: true
  validates :price, presence: true
  validates :unit, presence: true


  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address

  def full_address
    [address, city, state, country].compact.join(',')
  end
end
