class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show]

  def create
# <<<<<<< HEAD
#     order = current_user.orders.last
#     if order.nil? || !order.open?
#       order = current_user.orders.create
#     end
#     order.build_order(session[:cart_items])
#     redirect_to order_path(order)
#   end

    if session[:cart_items].count == 0
      redirect_to verification_path
    else
      @order = Order.create(user_id: session[:user_id], status: "ordered")
      @order.order_items = session[:cart_items].map { |item_id, quantity| OrderItem.new(item_id: item_id, quantity: quantity, order_id: @order)}
      # address = Address.where(id: params[:address])
      @order.address_id = params[:address]
      @order.save
      session[:cart_items] = {}
      redirect_to verification_path
    end
  end

  def index
      @orders = current_user.orders
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
    # @order = Order.find(params[:id])
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
      redirect_to new_user_path
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
