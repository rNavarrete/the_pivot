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
		@categories = Category.all
		@store = Store.find(params[:id])
		if store_owner?(@store)
		else
			@item = Item.new
		end
	end

	def update
		@store = Store.find(params[:id])
		if @store.update(store_params)
			@store.manager = User.where(email: params[:email]).first
 			flash[:notice] = "You're changes were sucessfully saved."
			redirect_to seller_dashboard_path
		else
			flash[:notice] = "Unable to save your changes."
			redirect_to seller_dashboard_path
		end
	end

	def add_manager
		@store = Store.find(params[:id])
		@store.users << User.where(:email_address => params[:email]).first
		raise "OMG"
	end

	private

	def store_params
		params.require(:store).permit(:name, :description, :image, :slug)
	end

	def store_owner?(store)
		stores = Store.where(:user_id => current_user.id)
		if stores.include?(store) or current_user.is? :admin
		else
    	redirect_to root_path
    	flash[:notice] = "This isn't your store."
    end
  end


end
