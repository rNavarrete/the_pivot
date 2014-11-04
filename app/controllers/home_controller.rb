class HomeController < ApplicationController
  def index
    @items = Item.limit(3).includes(:store)
  end

  def show
  end

  def code
    redirect_to 'https://github.com/glenegbert/the_pivot'
  end
end
