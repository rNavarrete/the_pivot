class Cart
  def initialize(session)
    @session ||= session
  end
  
  def add_item(item_id)
    cart[item_id] = 1
  end

  def remove_item(item_id)
    cart.delete(item_id)
  end

  def update_quantity(item_id, quantity)
    cart[item_id] = quantity
  end

  def items
    cart
  end

  private

  def cart
    @session[:cart] ||= {}
  end
end