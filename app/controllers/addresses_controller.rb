class AddressesController < ApplicationController


  def index
    @address = Address.new
    @addresses = Address.where(user_id: session[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = session[:id]
    if @address.save
    redirect_to addresses_path
    else
    render :new
    end


      # redirect_to complete_delivery_order_path
      # redirect_to controller: 'orders', action: 'create', address: @address
      # redirect_to new_order_path params: {address: @address}
      # if session[:cart_items].count == 0
      #   redirect_to verification_path
      # else
      #   @order = Order.create(user_id: session[:user_id], status: "ordered")
      #   @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
      #   @order.address = @address
      #   session[:cart_items] = {}
      #   redirect_to verification_path
      # end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:street_address, :city, :state, :zip)
  end
end
