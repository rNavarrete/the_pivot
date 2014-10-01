class CartsController < ApplicationController
  def show
    @cart = session[:cart]
  end

  def add_item
    item_id = params[:item_id]
    cart[item_id] = 1
    redirect_to cart_path
  end

  private

  def cart
    session[:cart] ||= {}
  end
end
