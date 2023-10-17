class Admin::OrdersController < Admin::SessionsController
  def show
    @order = Order.find(params[:id])
  end
end
