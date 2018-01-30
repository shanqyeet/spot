class ThingUpvotesController < ApplicationController
  after_commit :update_exp

  def create
    @upvote = ThingUpvote.new(upvote_params)
    @upvote.user_id = current_user.id
    if @upvote.save
      redirect_to request.referer
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

  def update_exp
    @thing = Thing.find(upvote_params)
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
    params.require(:thing_upvote).permit(:thing_id)
  end

end
