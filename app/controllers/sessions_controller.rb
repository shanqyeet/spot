class SessionsController < ApplicationController

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to root_path
      flash[:notice] = "Logged In!"
    else
      flash.now.alert = 'Email or password is invalid'
      redirect_to 'users#home'
    end
  end

  def logout
    log_out
    redirect_to root_path
    flash[:notice] = 'Logged out!'
  end
  
end
