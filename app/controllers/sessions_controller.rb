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

  def create_from_omniauth
     auth_hash = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

     # if: previously already logged in with OAuth
    if authentication != nil
       user = authentication.user
       authentication.update_token(auth_hash)
       @notice = "Signed in!"
     # else: user logs in with OAuth for the first time
    elsif (user = User.find_by(email: auth_hash['info']['email'])) != nil
        authentication = Authentication.create_with_omniauth(auth_hash)
        authentication.update(user_id: user.id)

    else
      authentication = Authentication.create_with_omniauth(auth_hash)
       user = User.create_with_auth_and_hash(authentication, auth_hash)
       # you are expected to have a path that leads to a page for editing user details
       @notice = "User created. Please confirm or edit details"
     end

     log_in(user)
     redirect_to "/" , :notice => @notice
   end

end
