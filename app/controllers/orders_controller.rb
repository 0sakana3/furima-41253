class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:format])
  end
end
