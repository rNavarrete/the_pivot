class CheckoutsController < ApplicationController
  layout "special_layout"

  def show
    if Order.last.status == nil
      @order = Order.last
      @order.order_items = session[:cart].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    else
      @order = Order.create(user_id: session[:user_id])
      @order.order_items = session[:cart].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    end
  end

  def complete_order
    if Order.last.status == nil
      @order = Order.last
      @order.status = "ordered"
      @order.save
    end
    session[:cart] = {}
    redirect_to categories_path
  end
end
