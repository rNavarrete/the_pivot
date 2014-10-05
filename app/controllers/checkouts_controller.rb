class CheckoutsController < ApplicationController
  layout "special_layout"

  def show
    if Order.last.status == nil
      @order = Order.last
    else
      @order = Order.create(user_id: session[:id])
      @order.order_items = session[:cart].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    end
  end
end
