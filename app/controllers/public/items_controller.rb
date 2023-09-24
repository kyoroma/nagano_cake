class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    puts @items.inspect
  end

  def show
    @item = Item.find(params[:id])
  end
end
