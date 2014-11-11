class OrderCreator

  def initialize(items_quantities_hash, user_id, shipping_address, billing_address )
    @items_quantities_hash = items_quantities_hash
    @user_id = user_id
    @shipping_address = shipping_address
    @billing_address = billing_address
  end

  def process_orders
    orders = @items_quantities_hash.map do |store_id, items|
      order = Order.create(user_id: @user_id, status: "ordered", store_id: store_id)
      items.map do |item_id, options|
        order.order_items.new(item_id: item_id, quantity: options[0], options: options[1])
      end

      order.shipping_address_id = @shipping_address
      order.billing_address_id = @billing_address
      order.save
      order_owner = order.store.user.id

      Resque.enqueue(OwnerConfirmationJob, order_owner, order.id)

      order
    end
  end


end
