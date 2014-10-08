class CheckoutsController < ApplicationController
  layout "special_layout"
  before_filter :authorize

  def show
    if cart.empty?
      redirect_to cart_path, notice: 'Please add items to your cart before checking out. Thank you!'
    else
      @subtotal = Checkout.subtotal(session)
      @tax = Checkout.tax(session)
      @total = Checkout.total(session)
    end
  end

  def complete_order

    @order = Order.create(user_id: session[:user_id], status: "ordered")
    @order.order_items = cart.items.map do |item_id, quantity|
      OrderItem.new(item_id: item_id, quantity: quantity)
    end

    session[:cart_items] = {}
    redirect_to verification_path
  end

  private

  def authorize
    unless !!current_user
      # flash[:error] = "You must be logged in to access this section"
      session[:return_to] = checkout_path
      redirect_to new_user_path
    end
  end
end
