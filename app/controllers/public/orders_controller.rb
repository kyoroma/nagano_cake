class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm_order
    @order = Order.new(order_params)
  end

  def order_completed
  end

  def place_order
    @order = Order.new(order_params)
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_fee, :payment_method, :total_price, :name, :address, :postal_code)
  end
end
