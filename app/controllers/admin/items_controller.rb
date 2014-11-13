
class Admin::ItemsController < Admin::BaseController
  def index
    # Queuing stores so I can have items organized by store
    @stores = Store.where(:online => true, :authorized => true)
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_store_path(@item.store_id), notice: 'Item Successfully Deleted!'
  end

  def create
    @categories = Category.all
    if item = Item.create(item_params)
      set_item_options(item, params)
      flash[:notice] = "Your item was successfully created"
      redirect_to admin_store_path(item.store.id)
    else
      flash[:notice] = "Something went wrong."
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @store = @item.store
    @categories = Category.all
  end

  def update
    @item = Item.find(params[:id])
    set_item_options(@item, params)
    if @item.update(item_params)
      #@item.categories = Category.where(id: params[:item][:category_ids])
      redirect_to admin_items_path, notice: 'Item Successfully Updated!'
    else
      render :edit
    end
  end

  def new
    @categories = Category.all
    @item = Item.new
    @store = Store.find(params[:store_id])
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
    item.save!
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status, :store_id)
  end
end
