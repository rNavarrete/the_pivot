class ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find(params[:id])
    @store = Store.find(@item.store_id)
  end
end
