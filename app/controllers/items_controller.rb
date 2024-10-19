class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end

  def create
  end

  private

  def item_params
  end
end
