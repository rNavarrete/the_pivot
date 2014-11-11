class WelcomeJob
  @queue = :create

  def self.perform(user_id)
  	user = User.find(user_id)
    WelcomeMailer.welcome_email(user).deliver
  end
end
