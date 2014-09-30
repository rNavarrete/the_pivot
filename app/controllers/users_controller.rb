class UsersController < ApplicationController
	layout "special_layout"
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to items_path, notice: "Please Sign In To Your New Account"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation, :role)
	end
end
