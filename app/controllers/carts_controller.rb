class CartsController < ApplicationController
  def show
    session[:return_to] = new_order_path
    @shipping_addresses = ShippingAddress.where(user_id: current_user.id)
    @billing_addresses = BillingAddress.where(user_id: current_user.id)
    if cart.items.any?
      @subtotal = Cart.subtotal(session)
      @tax = Cart.tax(session)
      @total = Cart.total(session)
    end
  end

  def add_item
    cart.add_item(params[:item_id], params[:options])
    #cart.add_options(params[:item_id], params[:options])
    item = Item.find(params[:item_id])
    store = Store.find(item.store_id)
    redirect_to stores_path(store.slug)
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
