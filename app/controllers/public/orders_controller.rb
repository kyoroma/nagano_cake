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
    end

    if @order.address == 'self'
      # ご自身の住所を設定
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.full_name
    elsif @order.address == 'registered' && @order.address_id.present?
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
    #customer = current_customer
    #address_id = params[:order][:address_id]

    #if address_id.present?
      #shipping_address = Address.find(address_id)
    #else
     # flash[:error] = "アドレスが見つかりません。正しいアドレスを選択または入力してください。"
      #redirect_to order_completed_public_orders_path
      #return
    #end

    #payment_method = params[:order][:payment_method].to_sym
    #shipping_fee = 800
    @order = current_customer.orders.new(order_params)

    @order.save!
    Rails.logger.debug("Order object before save: #{@order.inspect}")
    #order.save_order_information(customer, shipping_address, payment_method, shipping_fee)

    # カートアイテムを一つずつ処理
    current_customer.cart_items.each do |cart_item|
      @order.order_items.create(
        item: cart_item.item,
        amount: cart_item.amount,
        final_price: cart_item.item.with_tax_price
      )
      # カートアイテムを削除
    end

    current_customer.cart_items.destroy_all

    redirect_to order_completed_orders_path
  end

  def index
     @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
    @order_items = @order.order_items if @order
  end

  private

  def order_params
    params.require(:order).permit(:shipping_fee, :total_price, :payment_method, :address_type, :postal_code, :address, :name)
  end

  def calculate_total_price(cart_items)
    cart_items.sum { |cart_item| cart_item.subtotal }
  end
end
