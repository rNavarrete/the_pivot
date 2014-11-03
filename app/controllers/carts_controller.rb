class CartsController < ApplicationController
  def show
    if cart.items.any?
      @subtotal = Cart.subtotal(session)
      @tax = Cart.tax(session)
      @total = Cart.total(session)
    end
  end

  def add_item
    cart.add_item(params[:item_id])
    item = Item.find(:item_id)
    store = Store.find(item.store_id)
    redirect_to stores_path(store)
  end

  def remove_item
    cart.remove_item(params[:item_id])
    redirect_to cart_path
  end

  def update_quantity
    cart.update_quantity(params[:item_id], params[:quantity].to_i)
    redirect_to cart_path
  end
end
