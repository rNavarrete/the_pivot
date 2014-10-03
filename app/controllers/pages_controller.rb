class PagesController < ApplicationController

  def show
    redirect_to(categories_path)
  end
 # def current_user
 #   @user = User.find_by(email_address: params[:email_address])
 # end
end
