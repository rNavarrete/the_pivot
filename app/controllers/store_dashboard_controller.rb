class StoreDashboardController < ApplicationController

	def index

		@stores = Store.where(:user_id => current_user.id)

		if @stores.size == 1
			render :show
		else
			render :index
		end
	end

	def show

	end
end
