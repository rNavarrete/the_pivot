class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :cart
  helper_method :all_categories
  helper_method :default_options
  helper_method :has_no_store?
  helper_method :all_stores

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

  def all_stores
    Store.authorized.online
  end

  def default_options
    ["sizes","colors"]
  end

  def has_no_store?
    if current_user.nil?
      false
    elsif Store.where(:user_id => current_user.id).empty?
      true
    else
      false
    end
  end

end
