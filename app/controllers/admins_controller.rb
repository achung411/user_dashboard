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

	def update
	end

	def destroy
	end

	private
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
