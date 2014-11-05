class SellerController < ApplicationController

	def index
		@stores = Store.where(:user_id => current_user.id)
		if @stores.count == 1
			redirect_to store_edit_path(@stores.first.id)
		else
			render :index
		end
	end

	def show
		@store = Store.find(params[:id])
	end

	def edit
		@store = Store.find(params[:id])
		@item  = Item.new
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

	def store_params
		params.require(:store).permit(:name, :description, :image, :slug)
	end
end
