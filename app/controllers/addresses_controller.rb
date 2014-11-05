class AddressesController < ApplicationController
  def index
      @shipping_addresses = ShippingAddress.where(user_id: current_user.id)
      @billing_addresses = BillingAddress.where(user_id: current_user.id)
    session[:return_to] = addresses_path

  end

  def new
    @shipping_addresses = ShippingAddress.where(user_id: current_user.id)
    @billing_addresses = BillingAddress.where(user_id: current_user.id)
    if params[:category] == "shipping"
      @address = ShippingAddress.new
    elsif params[:category] == "billing"
      @address = BillingAddress.new
    elsif @shipping_addresses.count == 0 && @billing_addresses.count == 0
      @address = ShippingAddress.new
      @message = "Please Enter a Shipping Address"
      session[:return_to] = new_address_path
    elsif @billing_addresses.count == 0
      @address = BillingAddress.new
      @message = "Please Enter a Billing Address"
      session[:return_to] = new_order_path
    else
      @address = ShippingAddress.new
      @message = "Please Enter a Shipping Address"
      session[:return_to] = new_order_path
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
