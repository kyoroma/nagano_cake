class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
    render 'show'
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item), notice: '商品が作成されました。'
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: '商品が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to admin_items_path, notice: '商品が削除されました。'
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :tax_excluded_price, :other_fields)
  end
end
