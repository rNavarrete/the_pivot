class Admin::OrdersController < Admin::BaseController
  before_action :authorize

  def index
    status = params[:status]

    if status == "paid"
      @orders = Order.paid
    elsif status == 'completed'
      @orders = Order.completed
    elsif status == 'canceled'
      @orders = Order.canceled
    elsif status == 'ordered'
      @orders = Order.ordered
    else
      @orders = Order.all
    end
    @all = Order.all
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
