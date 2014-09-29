class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "login successful"
      redirect_to users_path
    else
      flash[:errors] = "invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to users_path
  end
end
