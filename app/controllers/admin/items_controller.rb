class Admin::ItemsController < ApplicationController
  before_action :authorize?
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path, notice: 'Category Successfully Deleted!'
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: 'Category Successfully Created!'
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      redirect_to admin_items_path, notice: 'Category Successfully Updated!'
    else
      render :edit
    end
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
