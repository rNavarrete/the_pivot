class OwnerConfirmationJob
  @queue = :create

  def self.perform(owner_id, order_id)
  	order_owner = User.find(owner_id)
  	order = Order.find(order_id)
    OwnerConfirmationMailer.owner_confirmation_email(order_owner, order).deliver
  end
end
