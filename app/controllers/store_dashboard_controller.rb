class StoreDashboardController < ApplicationController

	def index
		@stores = Store.where(:user_id => current_user.id)
		if @stores.count == 1
			redirect_to store_show_path(@stores.first.id)
		else
			render :index
		end
	end

	def show
		@store = Store.find(params[:id])
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
		params.require(:store).permit(:name, :description, :image_file_name, :image_content_type, :image_file_name, :image_updated_at)
	end
end
