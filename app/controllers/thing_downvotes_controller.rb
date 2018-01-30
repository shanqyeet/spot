class ThingDownvotesController < ApplicationController

  def create
    @downvote = ThingDownvote.new(downvote_params)
    @downvote.user_id = current_user.id
    if @downvote.save
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "Sorry we weren't able to register your vote, please try again."
    end
  end

  def destroy
    @downvote = ThingDownvote.where(downvote_params)
    @downvote.where(user_id: current_user.id)
    @downvote.destroy_all
    redirect_to request.referer
  end

  private

  def downvote_params
    params.require(:thing_downvote).permit(:thing_id)
  end

end
