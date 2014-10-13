class Admin::OrdersController < Admin::BaseController
  before_action :authorize

  def index
    status = params[:status]
    if Order.valid_statuses.include?(status)
      @orders = Order.where(status: status)
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
