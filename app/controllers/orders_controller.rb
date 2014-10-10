class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show]

  def create
    order = current_user.orders.last
    if order.nil? || !order.open?
      order = current_user.orders.create
    end
    order.build_order(session[:cart_items])
    redirect_to order_path(order)
  end

  def index
    # status = params[:status]

    # if status == "paid"
    #   @orders = Order.paid
    # elsif status == 'completed'
    #   @orders = Order.completed
    # else
      @orders = current_user.orders
    # end
  end

  def show
    # @order = Order.find(params[:id])
  end

  private

  def authenticate_user
    unless current_user
      flash[:notice] = 'Please log in or create account to complete order'
      session[:return_to] = cart_path
      redirect_to root_path
    end
  end

  def set_order
    # DEFINITELY NEEDS REFACTORING
    if current_user.orders.collect { |order| order.id }.include?(params[:id].to_i)
      @order = current_user.orders.find(params[:id])
    else
      redirect_to :root
    end
  end
end
