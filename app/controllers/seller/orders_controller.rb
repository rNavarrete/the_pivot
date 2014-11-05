class Seller::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to seller_dashboard_path, notice: "Order Successfully Updated"
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end