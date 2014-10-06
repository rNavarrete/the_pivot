class Checkout < ActiveRecord::Base

  def self.subtotal(session)
    prices = session[:cart].map do
      |item_id, quantity| Item.find(item_id).price * quantity.to_i
      end
    prices.reduce(:+)
  end

  def self.tax(session)
    subtotal(session) * ".05".to_f
  end

  def self.total(session)
    subtotal(session) + tax(session)
  end

end
