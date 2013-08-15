class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to link_url(@comment.link)
    else
      flash.notice = "Add comment failed."
      render :back
    end
  end
end
