class CommentsController < ApplicationController
	
  def create
  	render text: params
  end

  def destroy
  end
end
