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

    if session[:cart_items].count == 0
      redirect_to verification_path
    else
      @order = Order.create(user_id: session[:user_id], status: "ordered")
      @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
      session[:cart_items] = {}
      redirect_to verification_path
    end
  end

  def new
    if cart.empty?
      redirect_to cart_path, notice: 'Please add items to your cart before checking out. Thank you!'
    else
      @subtotal = Checkout.subtotal(session)
      @tax = Checkout.tax(session)
      @total = Checkout.total(session)
    end
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
