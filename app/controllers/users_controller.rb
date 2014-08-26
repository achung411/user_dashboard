class UsersController < ApplicationController
	layout "users"

	def index
		@everyone = User.all
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "User was successfully created."
			redirect_to "/signin"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/register"
		end
	end

	def new
	end

	def show
		@user = User.find(session[:user_id])
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :description)
		end
end
