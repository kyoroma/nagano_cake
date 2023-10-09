class Admin::HomesController < ApplicationController
  def top
    @orders = Order.order(created_at: :desc).includes(:customer)
  end
end
