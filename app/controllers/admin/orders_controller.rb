class Admin::OrdersController < Admin::BaseController
  before_action :authorize

  def index
    status = params[:status]

    if status == "paid"
      @orders = Order.paid
    elsif status == 'completed'
      @orders = Order.completed
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
