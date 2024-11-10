class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create]
  before_action :orderer_confirmation, only: [:index, :new, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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
      pay_item
      @orders_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_params
    @item = Item.find(params[:item_price])
  end

  def orders_params
    params.require(:orders_address).permit(:post_code, :prefecture_id, :order, :city, :address, :building_name,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id]).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: orders_params[:token],
      currency: 'jpy'
    )
  end

  def orderer_confirmation
    redirect_to root_path if current_user.id == @item.user_id
  end
end
