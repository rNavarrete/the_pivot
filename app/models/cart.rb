class Cart
  def initialize(session)
    @session ||= session
  end

  def add_item(item_id)
    items[item_id] = (items[item_id] || 0) + 1
  end

  def remove_item(item_id)
    items.delete(item_id)
  end

  def update_quantity(item_id, quantity)
    items[item_id] = quantity
  end

  def items
    @session[:cart_items] ||= {}
  end
end
