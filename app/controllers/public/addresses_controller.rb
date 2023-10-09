class Public::AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      redirect_to your_redirect_path_here
    else
      render 'new'
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
