require 'rails_helper'

RSpec.describe "home features" do

  before :each do
    User.create(email: 'spot@spot.com', password: '1234')
  end

 it "signs me in" do
   visit '/signin'
   within ".login-form" do
     fill_in 'Email', with: 'spot@spot.com'
     fill_in 'Password', with: '1234'
   end
   click_button 'Log In'
   expect(page).to have_content 'Successfully Logged In'
 end

 it "signs me in" do
   visit '/signin'
   within ".login-form" do
     fill_in 'Email', with: 'spot@tops.com'
     fill_in 'Password', with: '1234'
   end
   click_button 'Log In'
   expect(page).to have_content 'Email or password is invalid'
 end

end
