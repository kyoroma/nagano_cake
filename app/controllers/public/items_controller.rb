class Public::ItemsController < ApplicationController
  def index
    @items = Item.order(created_at: :desc).page(params[:page]).per(8)
    puts @items.inspect
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
