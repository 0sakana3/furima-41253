class OrdersController < ApplicationController
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
end
