class CheckoutsController < ApplicationController
  layout "special_layout"

  def show
  @order = Order.create(user_id: session[:id])
  @order.order_items = session[:cart].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}

  end
end
