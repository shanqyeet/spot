class UsersController < ApplicationController

  def home
    @all_things = Thing.all
    # @all_things = Thing.near("Subang Jaya, Selangor", 20)
    # @search = @search.where(["name LIKE ?","%#{params[:search]}%"]) if params[:search].present?
    # @search = @search.where("event_type = ?", params[:event_type]) if params[:event_type].present?
    # @search = @search.where("country = ?", params[:country]) if params[:country].present?
    # @search = @search.where("state = ?", params[:state]) if params[:state].present?
    # @search = @search.where("city = ?", params[:city]) if params[:city].present?
    @hash = Gmaps4rails.build_markers(@all_things) do |thing, marker|
      marker.lat thing.latitude
      marker.lng thing.longitude
      info = "#{thing.name} " + "#{thing.currency} " + "#{thing.price}"
      marker.infowindow info
    end
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
