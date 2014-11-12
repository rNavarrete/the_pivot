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
			@categories = Category.all
			@item = Item.new
		else
			flash[:notice] = "This isn't your store."
			redirect_to root_path
		end
	end

	def update
		@store = Store.find(params[:id])
		if @store.update(store_params)
 			flash[:notice] = "You're changes were sucessfully saved."
			redirect_to seller_dashboard_path
		else
			flash[:notice] = "Unable to save your changes."
			redirect_to seller_dashboard_path
		end
	end

	def add_manager
		@store = Store.find(params[:id])
		user = User.where(:email_address => params[:email]).first
		add_user_as_manager(@store, user)
	end

	def remove_manager
		@store = Store.find(params[:id])
		@store.users.where(:user_id => params[:user_id] )
	end

	private

	def store_params
		params.require(:store).permit(:name, :description, :image, :slug)
	end

	def store_owner?(store)
		current_user.is? :admin or my_store?(store) or store_managers(store).include?(current_user)
  end

  def my_store?(store)
  	Store.where(:user_id => current_user.id).include?(store)
  end

  def store_managers(store)
  	store.users
  end

  def add_user_as_manager(store, user)
  	if @store.users.include?(user)
			redirect_to :back
			flash[:notice] = "User is already a manager."
		elsif User.all.include?(user)
			@store.users << User.where(:email_address => params[:email]).first
			redirect_to seller_dashboard_path
			flash[:notice] = "Successfully added a manager to your store."
		else
			redirect_to :back
			flash[:notice] = "Unable to find this user"
		end
  end
end
