class CreateJob
  @queue = :create

  def self.perform(user_id, order_ids)
  	user = User.find(user_id)
  	orders = order_ids.map {|order_id| Order.find(order_id)}
    ConfirmationMailer.confirmation_email(user, orders).deliver
  end
end
