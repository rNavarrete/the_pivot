class Seller::SellerController < ApplicationController

	def index
		@stores = Store.where(:user_id => current_user.id)
		if @stores.count == 1
			redirect_to seller_store_edit_path(@stores.first.id)
		else
			render :index
		end
	end

	def show
		@store = Store.find(params[:id])
	end

	def edit
		@store = Store.find(params[:id])
		if store_owner?(@store)
		else
			@item = Item.new
		end
	end

	def create
		@store = Store.find(:user_id => current_user.id)
		if @store.items.create(item_params)
			flash[:notice] = "Your item was successfully created"
			redirect_to seller_store_show_path(@store.id)
		else
			flash[:notice] = "Something went wrong."
			redirect_to seller_store_show_path(@store.id)
		end
	end

	def update
		@store = Store.find(params[:id])
		if @store.update(store_params)
 			flash[:notice] = "You're changes were sucessfully saved."

			redirect_to store_show_path(@store.id)
		else
			flash[:notice] = "Unable to save your changes."
			redirect_to store_show_path(@store.id)
		end
	end

	private

	def store_params
		params.require(:store).permit(:name, :description, :image, :slug)
	end

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
