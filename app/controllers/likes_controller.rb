class LikesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    like = current_user.likes.build(item: @item)

    respond_to do |format|
      if like.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "like-btn-#{@item.id}_like",
            partial: 'likes/like',
            locals: { item: @item }
          )
        end
      else
        format.html { redirect_to request.referer, alert: 'いいねに失敗しました' }
      end
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    like = Like.find_by(item: @item, user: current_user)

    respond_to do |format|
      if like&.destroy
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "like-btn-#{@item.id}_like",
            partial: 'likes/like',
            locals: { item: @item }
          )
        end
      else
        format.html { redirect_to request.referer, alert: 'いいねを取り消せませんでした' }
      end
    end
  end
end
