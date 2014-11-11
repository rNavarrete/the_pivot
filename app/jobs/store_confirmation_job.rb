class StoreConfirmationJob
  @queue = :create

  def self.perform(user_id)
  	user = User.find(user_id)
    ConfirmationMailer.store_confirmation_email(user).deliver
  end
end
