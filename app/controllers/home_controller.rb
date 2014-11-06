class HomeController < ApplicationController
  def index
    stores = Store.authorized.online.limit(3)
    @items = stores.map {|store| store.items.sample}
  end

  def show
  end

  def code
    redirect_to 'https://github.com/glenegbert/the_pivot'
  end
end
