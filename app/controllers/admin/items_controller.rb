class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  def create
    @item = Item.create(item_params)
    redirect_to admin_items_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)
    redirect_to admin_items_path
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
