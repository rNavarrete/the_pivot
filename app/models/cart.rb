class Cart
  def initialize(session)
    @session ||= session
  end

  def add_item(item_id)
    cart[item_id] = 1
  end

  def items
    cart
  end

  private

  def cart
    @session[:cart] ||= {}
  end
end
