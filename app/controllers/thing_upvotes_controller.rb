class ThingUpvotesController < ApplicationController
  after_action :update_exp
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
    @upvote = ThingUpvote.find_by(upvote_params)
    @upvote.destroy
    redirect_to request.referer
  end

  def update_exp
    @thing = Thing.find_by(id: params[:thing_upvote][:thing_id])
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

  def upvote_params
    params.require(:thing_upvote).permit(:thing_id, :user_id)
  end

end
