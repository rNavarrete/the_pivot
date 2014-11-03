class StoreDashboardController < ApplicationController
	load_and_authorize_resource :class => Store
	def index
		@stores = Store.where(:user_id => current_user.id)

		if @stores.size == 1
			redirect_to store_dashboard_show_path(@stores.first.slug)
		else
			render :index
		end
	end

	def show
		@store = Store.find_by(:slug => params[:store_name])
	end
end
