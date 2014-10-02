class CartsController < ApplicationController
  def show
    @cart = cart
  end

  def add_item
    cart.add_item(item_id)
    redirect_to cart_path
  end

  private

  def cart
    @cart ||= Cart.new(session)
  end

  def item_id
    params[:item_id]
  end
end
