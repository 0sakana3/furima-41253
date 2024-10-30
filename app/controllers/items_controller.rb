class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    return unless @item.user_id != current_user.id

    redirect_to root_path
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :image, :explanation, :category_id, :situation_id, :shipping_fee_id,
                                 :prefecture_id, :time_required_id, :price).merge(user_id: current_user.id)
  end
end
