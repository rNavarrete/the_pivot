class CheckoutsController < ApplicationController
  layout "special_layout"

  def show
    @subtotal = Checkout.subtotal(session)
    @tax = Checkout.tax(session)
    @total = Checkout.total(session)

  end

  def complete_order
      @order = Order.create(user_id: session[:user_id], status: "ordered")
      @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    session[:cart_items] = {}
    redirect_to verification_path
  end


end
