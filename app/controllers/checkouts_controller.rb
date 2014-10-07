class CheckoutsController < ApplicationController
  layout "special_layout"
  before_filter :authorize

  def show
    @cart = cart
    @subtotal = Checkout.subtotal(session)
    @tax = Checkout.tax(session)
    @total = Checkout.total(session)

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
      redirect_to new_user_path
    end
  end

  def cart
    @cart ||= Cart.new(session)
  end

end
