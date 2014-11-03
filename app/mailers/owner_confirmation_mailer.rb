class OwnerConfirmationMailer < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def owner_confirmation_email(store_owner, order)
    @owner = store_owner
    @order = order
    mail(to: @owner.email_address, subject: "New Order Notification")
  end
end
