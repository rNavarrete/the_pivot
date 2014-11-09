class ItemsController < ApplicationController

  def index
  end

  def show
    if find_item
      @item = find_item
      @store = Store.find(@item.store_id)
    else
      redirect_to '/404'
    end
  end

  private
  def find_item
    Item.items_from_active_and_online_stores.detect do |item|
      item.id == params[:id].to_i
      end
  end
end
