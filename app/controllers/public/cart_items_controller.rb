class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.item.tax_included_price * item.amount }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: 'カート内商品を更新しました。'
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path, notice: 'カートから商品を削除しました。'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path, notice: 'カート内の全ての商品を削除しました。'
  end

  def create
    @item = Item.find_by(id: params[:item_id])

    if @item
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer = current_customer

      if @cart_item.save
        redirect_to public_cart_items_path, notice: 'カートに商品を追加しました。'
      else
        render 'public/items/show'
      end
    else
      redirect_to public_items_path, alert: '商品が見つかりませんでした。'
    end
  end

  private

  def cart_item_params
    params.permit(:item_id, :amount)
  end
end