class ThingDownvotesController < ApplicationController

  def create
    @downvote = ThingDownvote.new(downvote_params)
    @downvote.user_id = current_user.id
    if @downvote.save
      update_exp
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "Sorry we weren't able to register your vote, please try again."
    end
  end

  def destroy
    @downvote = ThingDownvote.find_by(downvote_params)
    @downvote.destroy
    update_exp
    redirect_to request.referer
  end

  def update_exp
    @thing = Thing.find(params[:thing_downvote][:thing_id])
    count = @thing.thing_upvotes.count - @thing.thing_downvotes.count
    if count <= 0
      @thing.update(allocated_exp: 0)
    elsif count > 0 && count <= 5
      @thing
    elsif count > 5 && count <= 15
      @thing.update(allocated_exp: 3)
    else
      @thing.update(allocated_exp: 5)
    end
  end

  private

  def downvote_params
    params.require(:thing_downvote).permit(:thing_id, :user_id)
  end

end
