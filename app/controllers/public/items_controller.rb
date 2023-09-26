class Public::ItemsController < ApplicationController
  def index
    @items = Item.order(created_at: :desc).limit(4)
    puts @items.inspect
  end

  def show
    @item = Item.find(params[:id])
  end
end
