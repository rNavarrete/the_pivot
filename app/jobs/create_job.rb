class CreateJob
  @queue = :create

  def self.perform(args)
    ConfirmationMailer.confirmation_email(args[0], args[1]).deliver
  end
end