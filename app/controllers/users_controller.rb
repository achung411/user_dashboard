class UsersController < ApplicationController
	layout "users"

	def index
		if not_logged_in
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		else
			@everyone = User.all
		end
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
		render layout: 'sessions'
	end

	def show
		if not_logged_in
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		else
			@user = User.find(params[:id])
		end
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :description)
		end

		def not_logged_in
			session[:user_id] == nil
		end
end
