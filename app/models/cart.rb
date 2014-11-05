class Cart
  def initialize(session)
    @session ||= session
  end

  def add_item(item_id, options)
    #refactoring needed
    if !items[item_id].nil?
      items[item_id] = [((items[item_id][0] || 0) + 1), (items[item_id][1] || options)]
    else
      items[item_id] = [((items[item_id] || 0) + 1), (items[item_id] || options)]
    end
  end

  def remove_item(item_id)
    items.delete(item_id)
  end

  def update_quantity(item_id, quantity)
    items[item_id][0] = quantity
  end

  def item(item_id)
    Item.find(item_id)
  end

  def line_item_price(item_id, quantity)
    item(item_id).price * quantity[0].to_i
  end

  def items
    @session[:cart_items] ||= {}
  end

  def empty?
    items.empty?
  end

  def self.subtotal(session)
    prices = session[:cart_items].map do |item_id, quantity|
      Item.find(item_id).price * quantity[0].to_i
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
