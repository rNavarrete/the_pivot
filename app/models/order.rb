class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def build_order(cart)
    cart.each do |item, quantity|
      OrderItem.create(order_id: self.id, item_id: item, quantity: quantity )
    end
  end
end
