class UsersController < ApplicationController

  def home
    @all_things = Thing.order(created_at: :desc)
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

  def signup
  end

  def signin
  end

  def show
    @user = User.find(params[:id])
    @all_things = Thing.where(user_id:@user.id).order(created_at: :desc)
    # Sum all exp and update user exp
      collect = []
      @all_things.each do |a|
        collect << a.allocated_exp
      end
      sum_exp = collect.sum
      @user.update(exp: sum_exp)
    # Check and Update User Level
      if @user.level != @user.check_level
        @user.update(level: @user.check_level)
      else
        @user
      end
  end

  def create
    @user = User.new(user_params)
    @user.level = 1
    @user.exp = 0
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end
    log_in @user
    redirect_to @user
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end


end
