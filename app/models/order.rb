class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  # def build_order(cart)
  #   cart.each do |item, quantity|
  #     OrderItem.create(order_id: self.id, item_id: item, quantity: quantity )
  #   end
  # end

  def subtotal
    line_totals = order_items.map {|order_item| order_item.line_total}
    line_totals.reduce(:+)
  end

  def tax
    subtotal * ".05".to_f
  end

  def total
    subtotal + tax
  end
end
