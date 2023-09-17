class Public::CustomersController < ApplicationController
  def my_page
  end

  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to public_customers_my_page_path, notice: '登録情報が更新されました。'
    else
      render :edit
    end
  end

  def confirm_deactivation
  end

  def deactivate
    current_customer.update(active: false)
    redirect_to public_customers_confirm_deactivation_path, notice: '退会処理が完了しました。'
  end
  
  private

  def customer_params
    if params[:customer][:password].present?
      params.require(:customer).permit(:name, :email, :password, :password_confirmation)
    else
      params.require(:customer).permit(:name, :email)
    end
  end
end
