require 'rails_helper'

RSpec.describe "home features" do

  before :each do
    User.create(email: 'test@test.com', password: '1234')
  end

 it "signs me in" do
   visit '/'
   within ".login-form" do
     fill_in 'Email', with: 'test@test.com'
     fill_in 'Password', with: '1234'
   end
   click_button 'Log In'
   expect(page).to have_content 'Logged In!'
 end

end
