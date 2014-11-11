class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show]

  def create
    if session[:cart_items].empty?
      redirect_to confirmation_path
    else
      items_by_store_id = session[:cart_items].group_by{|item| Item.find(item[0].to_i).store_id}
      order_creator = OrderCreator.new(items_by_store_id, session[:user_id], params[:order]["shipping_address_id"], params[:order]["billing_address_id"])
      orders = order_creator.process_orders

      totals = orders.map {|order| order.total}
      order_total = totals.reduce(:+)
      Resque.enqueue(CreateJob, [current_user, orders])

      session[:cart_items] = {}
      session[:order_total] = order_total
      redirect_to new_charge_path
    end
  end

  def index
    @orders = current_user.orders
  end

  def new
    session[:return_to] = new_order_path
    @shipping_addresses = current_user.shipping_addresses
    @billing_addresses = current_user.billing_addresses
    if cart.empty?
      redirect_to cart_path, notice: 'Please add items to your cart before checking out. Thank you!'
    elsif @shipping_addresses.empty?
      flash[:message] = 'Please Enter a Shipping Address'
      redirect_to new_address_path(category: "shipping")
    elsif @billing_addresses.empty?
      flash[:message] = 'Please Enter a Billing Address'
      redirect_to new_address_path(category: "billing")
    end
  end

  def show
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
    if current_user.orders.collect { |order| order.id }.include?(params[:id].to_i)
      @order = current_user.orders.find(params[:id])
    else
      redirect_to :root
    end
  end
end
