class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.order(created_at: :desc).includes(:customer,order_items: :item)
    # 例: ページごとに10件ずつデータを取得
    @orders = Order.page(params[:page]).per(10)
  end
end
