class CheckoutsController < ApplicationController

  def show
    if session[:cart_items] == {}
      redirect_to cart_path, notice: 'Please add items to your cart before checking out. Thank you!'
    else
      @subtotal = Checkout.subtotal(session)
      @tax = Checkout.tax(session)
      @total = Checkout.total(session)
    end
  end

  def complete_order
      @order = Order.create(user_id: session[:user_id], status: "ordered")
      @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    session[:cart_items] = {}
    redirect_to verification_path
  end


end
