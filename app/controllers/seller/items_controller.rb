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
    flash[:notice] = 'Item Successfully Deleted!'
    redirect_to :back
  end

  def create
    @categories = Category.all
    @store = Store.find(params[:item][:store_id])
    if authorized_to_create?(@store) &&  @store.items.create(item_params)
      set_item_options(@store.items.last, params)
      flash[:notice] = "Your item was successfully created"
      redirect_to seller_store_edit_path(@store.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to seller_store_edit_path(@store.id)
    end
  end

  def edit
    @categories = Category.all
    if item_creator?(params[:id]) or item_manager?(params[:id])
      @item = Item.find(params[:id])
    else
      flash[:notice] = "This isn't your item."
      redirect_to seller_dashboard_path
    end
  end

  def update
    @item = Item.find(params[:id])
    set_item_options(@item, params)
    if @item.update(item_params)
      redirect_to seller_store_edit_path(@item.store.id), notice: 'Item Successfully Updated!'
    else
      redirect_to seller_store_edit_path(@item.store.id), notice: "Item coundn't be updated!"
    end
  end

  def new
    @item = Item.new
  end

  private

  def set_item_options(item, params)
    item.options = params[:options]
    item.save!
    categories = params[:categories] || []
    item.categories.clear
    categories.each do |category|
      category = Category.find(category)
      item.categories << category
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end

  def item_creator?(params_id)
    stores = Store.where(:user_id => current_user.id)
    stores.any? do |store|
      store.items.any? do |item|
        item.id == Item.find(params_id).id
      end
    end
  end

  def item_manager?(params_id)
    item = Item.find(params_id)
    item.store.users.include?(current_user)
  end

  def authorized_to_create?(store)
    current_user.id == store.user.id || store.users.include?(current_user)
  end
end
