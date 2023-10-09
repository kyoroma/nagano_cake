class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @cart_items.each do |cart_item|
      cart_item.total_price = cart_item.item.with_tax_price * cart_item.amount
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: 'カート内商品を更新しました。'
    else
      @cart_items = current_customer.cart_items
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
    @cart_item = current_customer.cart_items.find_by(item: @item)

    if @cart_item
      # 既にカートに存在する場合
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      if @cart_item.update(amount: new_amount)
        redirect_to public_cart_items_path, notice: 'カート内の商品数量を更新しました。'
      else
        # 更新に失敗した場合の処理
        render 'public/items/show'
      end
    else
      # カートに存在しない場合
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer = current_customer

      if @cart_item.save
        redirect_to public_cart_items_path, notice: 'カートに商品を追加しました。'
      else
        render 'public/items/show'
      end
    end
  end

  private

  def cart_item_params
    params.permit(:item_id, :amount)
  end
end