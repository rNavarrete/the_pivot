class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize
    if current_user == nil
      redirect_to '/'
    elsif current_user.role != 'admin'
      redirect_to '/'
    end
  end

  # use this method, not the ivar, b/c this sets the ivar
  #
  def cart
    @cart ||= Cart.new(session)
  end

  helper_method :current_user
  helper_method :cart
end
