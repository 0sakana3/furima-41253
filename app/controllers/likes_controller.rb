class LikesController < ApplicationController
  def create
    like = current_user.likes.build(item_id: params[:item_id])
    like.save
  end

  def destroy
    like = Like.find_by(item_id: params[:item_id], user_id: current_user.id)
    like.destroy
  end
end
