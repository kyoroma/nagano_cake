class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def my_page
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customer_my_page_path(@customer), notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  def confirm_deactivation
  end

  def deactivate
    @customer = current_customer
    if @customer.update(is_active: false)
      sign_out @customer
      redirect_to public_home_top_path, notice: "退会しました。ご利用ありがとうございました。"
    else
      redirect_to public_customer_my_page_path, alert: "退会処理中にエラーが発生しました。もう一度お試しください。"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :password, :password_confirmation,
    :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number)
  end
end
