class SessionsController < ApplicationController
  layout "sessions"
  
  def index
  end

  def new
  end

  def create
  	user = User.authenticate(session_params[:email], session_params[:password])
  	if user.nil?
  		flash[:error] = "There is no user registered with that name & email address."
  		redirect_to "/signin"
  	else
  		session[:user_id] = user.id
  		session[:first_name] = user.first_name
  		redirect_to "/users/"
  	end
  end

  def destroy
    reset_session
  	flash[:notice] = "You have signed out."
  	redirect_to "/signin"
  end

  private
  def session_params
  	params.require(:session).permit(:email, :password)
  end
end