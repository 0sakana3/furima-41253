class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create]
  before_action :orderer_confirmation, only: [:index, :new, :create]
  def index
    @item = Item.find(params[:item_id])
    @orders_address = OrdersAddress.new
  end

  def new
    @orders_address = OrdersAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @orders_address = OrdersAddress.new(orders_params)
    if @orders_address.valid?
      @orders_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def orders_params
    params.require(:orders_address).permit(:post_code, :prefecture_id, :order, :city, :address, :building_name,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def orderer_confirmation
    redirect_to root_path if current_user.id == @item.user_id
  end
end
