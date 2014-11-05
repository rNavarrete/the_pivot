class ChargesController < ApplicationController

  def new
    @amount = session[:order_total]
  end

def create
  # Amount in c
  @amount = (session[:order_total].to_f*100).to_i
  @total_paid = session[:order_total]
  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path


end
end
