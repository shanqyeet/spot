require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'user associations' do
    it {should have_many(:things)}
    it {should have_many(:authentications)}
    it {should have_many(:thing_upvotes)}
    it {should have_many(:thing_downvotes)}
    it {should have_many(:shopping_items)}
  end

  describe 'user validations' do
    subject { User.create(email: "test@test.com")}
    it {should validate_presence_of(:password)}
    it {should validate_confirmation_of(:password)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should have_secure_password}
  end

  describe "User Custom Methods" do

    it "name method should produce concat of first and last name" do
      @user = User.create(email:"test@test.com", password:"1234", first_name:"foo", last_name:"bar")
      expect(@user.name).to eq("foo, bar")
    end

    it "name method should not produce wrong sequence" do
      @user = User.create(email:"test@test.com", password:"1234", first_name:"foo", last_name:"bar")
      expect(@user.name).not_to eq("bar, foo")
    end

    it "exp_calc method should return true on right calculation" do
      @user = User.create(email:"test@test.com", password:"1234", level:1, exp:50)
      expect(@user.exp_calc).to eq(100.00)
    end

    it "exp_calc method should return false on wrong calculation" do
      @user = User.create(email:"test@test.com", password:"1234", level:1, exp:50)
      expect(@user.exp_calc).not_to eq(33.33)
    end

    it "check_level method should return one level higher when exp_celc eq 100" do
      @user = User.create(email:"test@test.com", password:"1234", level:1, exp:50)
      expect(@user.check_level).to eq(2)
    end

    it "check_level method should same level higher when exp_celc less than 100" do
      @user = User.create(email:"test@test.com", password:"1234", level:1, exp:30)
      expect(@user.check_level).to eq(1)
    end

    it "check_level method should return false when wrong level output is expected" do
      @user = User.create(email:"test@test.com", password:"1234", level:1, exp:50)
      expect(@user.check_level).not_to eq(1)
    end


  end

end
