
class Admin::ItemsController < ApplicationController
  before_action :authorize
  def index
    @items = Item.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path, notice: 'Item Successfully Deleted!'
  end

  def create
    @item = Item.create(item_params)
    redirect_to admin_items_path, notice: 'Item Successfully Created!'
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)
    @item.categories = Category.where(id: params[:item][:category_ids])
    redirect_to admin_items_path, notice: 'Item Successfully Updated!'
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids)
  end
end
