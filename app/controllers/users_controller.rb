class UsersController < ApplicationController

  def home

  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end
    @user.errors
    redirect_to request.referrer
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end


end
