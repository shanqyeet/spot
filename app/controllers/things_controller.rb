class ThingsController < ApplicationController

  def new
    @things = Thing.new
  end

  def create
    @thing = Thing.new(thing_params)
    @thing.user_id = current_user.id
    @thing.category_id = Category.find_by(name:params[:thing][:category]).id
    if @thing.save
      redirect_to root_path, notice: "You have successfully spotted a new thing!"
    else
      @thing.errors
      redirect_to request.referer, notice:"There is an error in your last spotting, please try again"
    end
  end

  def search
    @search = Thing.all
    @search = @search.where(["name LIKE ?","%#{params[:search]}%"]) if params[:search].present?
    @search = @search.where("country = ?", params[:country]) if params[:country].present?
    @search = @search.where("state = ?", params[:state]) if params[:state].present?
    @search = @search.where("city = ?", params[:city]) if params[:city].present?
    @hash = Gmaps4rails.build_markers(@search) do |thing, marker|
      marker.lat thing.latitude
      marker.lng thing.longitude
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:name, :currency, :price, :unit, :vendor, :address, :city, :state, :country, :longitude, :latitude)
  end
end
