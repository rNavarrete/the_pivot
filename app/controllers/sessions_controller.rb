class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email_address: params[:email_address])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # flash[:notice] = "login successful"
      redirect_path = session[:return_to] || :back
      redirect_to(redirect_path)
    else
      flash[:errors] = "invalid login"
      redirect_path = session[:return_to] || :back
      redirect_to(redirect_path)
    end
  end

  def destroy
    session.clear
    redirect_to items_path
  end
end
