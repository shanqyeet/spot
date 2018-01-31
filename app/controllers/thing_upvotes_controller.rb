class ThingUpvotesController < ApplicationController

  def create
    @upvote = ThingUpvote.new(upvote_params)
    @upvote.user_id = current_user.id
    if @upvote.save
      {vote:1, saved: true}.to_json
      # redirect_to request.referer
    else
      redirect_to request.referer, notice: "Sorry we weren't able to register your vote, please try again."
    end
  end

  def destroy
    @upvote = ThingUpvote.where(upvote_params)
    @upvote.where(user_id: current_user.id)
    @upvote.destroy_all
    redirect_to request.referer
  end

  private

  def upvote_params
    params.require(:thing_upvote).permit(:thing_id)
  end
end
