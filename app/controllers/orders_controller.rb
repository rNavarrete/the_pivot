class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    #if user's first order
    #if user has orders, but last one is closed
    #if user has orders, but last one is open
    order = current_user.orders.last
    if order.nil? || !order.open?
      order = current_user.orders.create
    end
    # binding.pry
    order.build_order(session[:cart_items])
    redirect_to order_path(order)
  end

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

  private

  def authenticate_user
    unless current_user
      flash[:notice] = 'Please log in or create account to complete order'
      session[:return_to] = cart_path
      redirect_to root_path
    end
  end
end
