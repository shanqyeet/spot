class ShoppingItemsController < ApplicationController

    def index
      if current_user
        @shopping_items = ShoppingItem.order(created_at: :asc)
      else
        redirect_to '/'
      end
    end

    def create
      @shopping_item = ShoppingItem.new(item_params)
      @shopping_item.user_id = current_user.id
      if @shopping_item.save
        redirect_to request.referer
      else
        redirect_to request.referer, notice:"Sorry, there was a problem creating you new item, please try again."
      end
    end

    def check
      @status = ShoppingItem.find_by(item_params)
      @status.Checked!
      render json: {user_id: @status.user_id, id:@status.id}
      # redirect_to request.referer
    end

    def uncheck
      @status = ShoppingItem.find_by(item_params)
      @status.Unchecked!
      render json: {user_id: @status.user_id, id:@status.id}
      # redirect_to request.referer
    end

    private

    def item_params
      params.require(:shopping_item).permit(:item, :user_id, :id)
    end

end
