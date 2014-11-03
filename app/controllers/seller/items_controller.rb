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
    redirect_to seller_dashboard_path, notice: 'Item Successfully Deleted!'
  end

  def create
    @store = Store.find_by(:user_id => current_user.id)
    if @store.items.create(item_params)
      flash[:notice] = "Your item was successfully created"
      redirect_to seller_store_edit_path(@store.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to seller_store_edit_path(@store.id)
    end
  end

  def edit
    @item = Item.find(params[:id])
    if store_owner?(Store.find(@item.store_id))
    else
      flash[:notice] = "You do not own this store."
      redirect_to seller_dashboard_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.categories = Category.where(id: params[:item][:category_ids])
      redirect_to seller_dashboard_path, notice: 'Item Successfully Updated!'
    else
      render_to seller_dashboard_path, notice: "Item coundn't be updated!"
    end
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end

  def store_owner?(store)
    stores = Store.where(:user_id => current_user.id)
    if stores.include?(store)
    else
      redirect_to root_path
      flash[:notice] = "Unauthorized"
    end
  end
end
