class ContactUsController < ApplicationController

  def new
    @contact = ContactUs.new
  end

  def create
    @contact = ContactUs.new(contact_us_params)
    @contact.request = request

    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  private

  def contact_us_params
    params.require(:contact_us).permit(:name, :email, :message, :nickname)
  end
end
