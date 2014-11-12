class ChargesController < ApplicationController

  def index
    @total_paid = session[:order_total]
  end

end
