class Admin::OrdersController < Admin::BaseController

  def index
    @paid_orders = Order.where(:status => "paid")
    @completed_orders = Order.where(:status => "completed")
    @canceled_orders = Order.where(:status => "canceled")
    @ordered = Order.where(:status => "ordered")
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_orders_path, notice: "Order Successfully Updated"
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
