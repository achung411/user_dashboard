class AdminsController < ApplicationController
	layout "users"

	def index
		if not_logged_in?
			flash[:error] = "Please sign in."
			redirect_to "/signin"
		else
			@everyone = User.all 
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
end
