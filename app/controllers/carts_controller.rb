class CartsController < ApplicationController
  def show
    @cart = cart
  end

  def add_item
    cart.add_item(params[:item_id])
    redirect_to cart_path
  end

  def remove_item
    cart.remove_item(params[:item_id])
    redirect_to cart_path
  end

  def update_quantity
    cart.update_quantity(params[:item_id], params[:quantity])
    redirect_to cart_path
  end

  private

  def cart
    @cart ||= Cart.new(session)
  end
end
