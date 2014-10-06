class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email_address: params[:email_address])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # flash[:notice] = "login successful"
      redirect_to(:back)
    else
      flash[:errors] = "invalid login"
      redirect_to(:back)
    end
  end

  def destroy
    session.clear
    redirect_to items_path
  end
end
