class Admin::OrdersController < ApplicationController
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
end
