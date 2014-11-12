class HomeController < ApplicationController
  def index
    @items = Item.custom_items.sample(3)
  end

  def code
    redirect_to 'https://github.com/glenegbert/the_pivot'
  end
end
