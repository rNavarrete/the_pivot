class OrderItem < ActiveRecord::Base
	serialize :options

  belongs_to :order
  belongs_to :item

  validates :order_id, presence: :true
  validates :item_id, presence: :true


  def line_total
    item.price * quantity
  end

end
