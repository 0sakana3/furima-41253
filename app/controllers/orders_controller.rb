class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :orderer_confirmation, only: [:index, :create]
  before_action :soldout_confirmation, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @orders_address = OrdersAddress.new
  end

  def create
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

  def orders_params
    params.require(:orders_address).permit(:post_code, :prefecture_id, :city, :address, :building_name,
                                           :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
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

  def soldout_confirmation
    redirect_to root_path unless @item.order.nil?
  end
end
