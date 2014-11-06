class UsersController < ApplicationController
	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			WelcomeMailer.welcome_email(@user).deliver
			redirect_path = session[:return_to] || '/'
			redirect_to redirect_path, notice: "You Have Successfully Created A New Account!"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to '/', notice: 'Information Successfully Updated!'
		else
			render :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:full_name, :email_address, :screen_name, :password, :password_confirmation)
	end
end
