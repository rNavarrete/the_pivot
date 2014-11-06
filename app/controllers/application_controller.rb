class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :cart
  helper_method :all_categories
  helper_method :default_options
  helper_method :has_no_store?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def cart
    @cart ||= Cart.new(session)
  end

  def all_categories
    Category.all
  end

  def default_options
    ["sizes","colors"]
  end

  def has_no_store?
    current_user.nil? || Store.where(:user_id => current_user.id).nil?
  end

end
