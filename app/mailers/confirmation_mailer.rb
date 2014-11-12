class ConfirmationMailer < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def confirmation_email(user, orders)
    @user = user
    @orders = orders
    mail(to: @user.email_address, subject: "Order Confirmation" )
  end

  def store_confirmation_email(user)
  	@user = user
    mail(to: @user.email_address, subject: "Store Approved!" )
  end
end
