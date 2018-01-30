class ThingsController < ApplicationController

  def new
    @things = Thing.new
  end

  def create
    @thing = Thing.new(thing_params)
    @thing.user_id = current_user.id
    @thing.category_id = Category.find_by(name:params[:thing][:category]).id
    if @thing.save
      @thing.errors
      redirect_to root_path, notice: "You have successfully spotted a new thing!"
    else
      @thing.errors
      redirect_to request.referer, notice:"There is an error in your last spotting, please try again"
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:name, :currency, :price, :unit, :vendor, :address, :city, :state, :country, :longitude, :latitude)
  end
end
