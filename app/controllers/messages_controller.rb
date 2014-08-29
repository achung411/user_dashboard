class MessagesController < ApplicationController
  def create
  	# render text: message_params
  	@message = Message.new(user: User.find(message_params[:user_id]), content: message_params[:content], author: User.find(session[:user_id]))
	if @message.save
		flash[:notice] = "Message was successfully posted."
	else
		flash[:errors] = @message.errors.full_messages
	end
	redirect_to :back
  end

  def destroy
  end

  private
  def message_params
  	params.require(:message).permit(:user_id, :content)
  end
end