class UsersController < ApplicationController
	layout "users"

	def index
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
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
