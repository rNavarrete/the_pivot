class AddressesController < ApplicationController
  def index
    session[:return_to] = addresses_path
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
