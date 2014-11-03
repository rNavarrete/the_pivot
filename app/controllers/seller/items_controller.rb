class Seller::ItemsController < ApplicationController

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
    redirect_to seller_items_path, notice: 'Item Successfully Deleted!'
  end

  def create
    @store = Store.find_by(:user_id => current_user.id)
    if @store.items.create(item_params)
      flash[:notice] = "Your item was successfully created"
      redirect_to seller_store_edit_path(@store.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to seller_store_show_path(@store.id)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.categories = Category.where(id: params[:item][:category_ids])
      redirect_to admin_items_path, notice: 'Item Successfully Updated!'
    else
      render :edit
    end
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end
end
