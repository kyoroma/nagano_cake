class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      if @cart_item.amount == 0
        @cart_item.destroy
      end
      redirect_to cart_items_path, notice: 'カート内商品を更新しました。'
    else
      @cart_items = current_customer.cart_items
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'カートから商品を削除しました。'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カート内の全ての商品を削除しました。'
  end

  def create

    @item = Item.find_by(id: params[:cart_item][:item_id])
    @cart_item = current_customer.cart_items.find_by(item_id: @item.id)
    #byebug
    if @cart_item
      # 既にカートに存在する場合
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      if @cart_item.update(amount: new_amount)
        redirect_to cart_items_path, notice: 'カート内の商品数量を更新しました。'
      else
        # 更新に失敗した場合の処理
        render 'public/items/show'
      end
    else
      # カートに存在しない場合
      cart_item = current_customer.cart_items.new(cart_item_params)

      if cart_item.save!
        redirect_to cart_items_path, notice: 'カートに商品を追加しました。'
      else
        render 'public/items/show'
      end
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end