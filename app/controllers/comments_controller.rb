class CommentsController < ApplicationController
  def create
  	@comment = Comment.new(user: User.find(comment_params[:user_id]), content: comment_params[:content], message: Message.find(comment_params[:message_id]), author: User.find(session[:user_id]))
  	if @comment.save
  		flash[:notice] = "Response was successfully posted."
  	else
  		flash[:errors] = @comment.errors.full_messages
  	end
  	redirect_to :back
  end

  def destroy
  end

  private
  def comment_params
  	params.require(:comment).permit(:user_id, :message_id, :content)
  end
end