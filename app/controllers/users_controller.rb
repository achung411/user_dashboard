class UsersController < ApplicationController
	layout "users"

	def index
		if not_logged_in?
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		elsif !normal_user?
			redirect_to "/admins/"
		else
			@everyone = User.all
		end
	end

	def create
		@user = User.new(user_params)
		
		if User.count == 0
			@user.update_attribute(:admin, 9)
		else
			@user.update_attribute(:admin, 1)
		end

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
		if not_logged_in?
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		else
			@user = User.find(params[:id])
		end
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end

		def not_logged_in?
			session[:user_id] == nil
		end

		def normal_user?
			User.find(session[:user_id]).admin == "1"
		end
end
