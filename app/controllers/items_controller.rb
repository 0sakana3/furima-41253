class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #@items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :image, :explanation, :category_id, :situation_id, :shipping_fee_id,
                                 :prefecture_id, :time_required_id, :price).merge(user_id: current_user.id)
  end
end
