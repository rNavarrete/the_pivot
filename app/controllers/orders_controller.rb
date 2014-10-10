class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    # #if user's first order
    # #if user has orders, but last one is closed
    # #if user has orders, but last one is open
    # order = current_user.orders.last
    # if order.nil? || !order.open?
    #   order = current_user.orders.create
    # end
    # # binding.pry
    # order.build_order(session[:cart_items])
    # redirect_to order_path(order)
    
    @order = Order.create(user_id: session[:user_id], status: "ordered")
    @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
    @order.address = params[:address]
    session[:cart_items] = {}
    redirect_to verification_path
  end

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
  end

  def edit
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
