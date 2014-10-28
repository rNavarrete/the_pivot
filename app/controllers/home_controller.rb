class HomeController < ApplicationController
  def index
    @items = Item.all
  end

  def show
  end

  def code
    redirect_to 'https://github.com/glenegbert/the_pivot'
  end
end
