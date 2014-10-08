class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

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
