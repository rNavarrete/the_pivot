class AddressesController < ApplicationController
  def index
    if Address.where(user_id: session[:id]).count != 0
      @shipping_addresses = ShippingAddress.where(user_id: current_user.id)
      @billing_addresses = BillingAddress.where(user_id: current_user.id)
    else
      redirect_to new_address_path
    end
    session[:return_to] = addresses_path
    @address = Address.new
  end

  def new
    if params[:category] == "shipping"
      @address = ShippingAddress.new
    else
      @address = BillingAddress.new
    end
  end

  def create
    @address = params[:category].constantize.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      redirect_path = session[:return_to]
      redirect_to(redirect_path)
    else
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Item Successfully Updated!'
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:street_address, :city, :state, :zip)
  end
end
