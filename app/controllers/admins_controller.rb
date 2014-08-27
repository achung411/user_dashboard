class AdminsController < ApplicationController
	layout "users"

	def index
		if not_logged_in?
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		elsif normal_user?
			redirect_to "/users/"
		elsif admin?
			@everyone = User.all 
		else
			flash[:error] = "There is a problem with your account.  Please contact an administrator."
			redirect_to "/signin"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user  = User.find(params[:id])

		if params[:user][:admin] == "admin"
			if !@user.update(admin: 9.42)
				flash[:error] = @user.errors.full_messages
			end
		else
			if !@user.update(admin: 1)
				flash[:error] = @user.errors.full_messages
			end
		end

		if @user.update(user_params)
			flash[:notice] = "User information has successfully been updated."
			redirect_to action: "edit"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to action: "edit"
		end			
	end


	def destroy
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

	def admin?
		User.find(session[:user_id]).admin == "9.42"
	end
end
