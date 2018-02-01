require 'rails_helper'

RSpec.describe Thing, type: :model do

  describe "thing association" do
    it {should belong_to(:category)}
    it {should belong_to(:user)}
    it {should have_many(:thing_upvotes)}
    it {should have_many(:thing_downvotes)}
  end

  describe "thing validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:currency)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:unit)}
  end

  describe "geocoder" do
    it "should produce single string of full address" do
      @thing = Thing.create(user_id:1, category_id: 1, name: "papaya", currency: "MYR", price:2.00, unit:"100 gram",address:"Jalan Tun Razak", city:"Kuala Lumpur", state:"Kuala Lumpur", country:"MY")
      p @thing
      expect(@thing.full_address).to eq "Jalan Tun Razak,Kuala Lumpur,Kuala Lumpur,MY"
    end
  end

end
