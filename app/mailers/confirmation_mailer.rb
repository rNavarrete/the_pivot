class ConfirmationMailer < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def confirmation_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email_address, subject: "Dope Threads: Order Confirmation" )
  end
end
