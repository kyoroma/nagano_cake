class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm_order
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.full_name
    @order.total_price = calculate_total_price(@cart_items)
    @order.shipping_fee = 800

    if params[:order][:address_id].present?
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @address = Address.new(
        customer_id: current_customer.id,
        postal_code: params[:order][:postal_code],
        address: params[:order][:address].to_s,
        name: params[:order][:name]
      )

      if @address.save
        flash[:success] = "新しいお届け先が保存されました。"
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        flash[:error] = "お届け先の保存に失敗しました。エラーメッセージを確認してください。"
        render :confirm_order
      end
    end

    if @order.address_type == 'self'
      # ご自身の住所を設定
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.full_name
    elsif @order.address_type == 'registered' && @order.address_id.present?
      # 登録済みの住所を設定
      selected_address = Address.find(@order.address_id)
      @order.address = selected_address.address
      @order.postal_code = selected_address.postal_code
      @order.name = selected_address.name
    end
  end

  def order_completed
  end

  def place_order
    @order = Order.new(order_params)
    @order.shipping_fee = 800

    if @order.save
       params[:order][:cart_items].each do |item|
        OrderItem.create!(
          order_id: @order,
          item_id: item[:item_id],
          amount: item[:amount],
          final_price: Item.find(item[:item_id]).price
        )
      end
      current_customer.cart_items.destroy_all

      redirect_to order_completed_public_orders_path
    else
      render :new
    end
  end

  def index
     @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
    :shipping_fee, :total_price, :payment_method, :address_type, :address_id, :postal_code, :address, :name,
    cart_items: [:item_id, :amount]  # cart_items内のパラメータを許可
  )
  end

  def calculate_total_price(cart_items)
    cart_items.sum { |cart_item| cart_item.subtotal }
  end
end
