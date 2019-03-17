class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "You commented!"
      redirect_to root_path 
    else
      flash[:alert] = "Something went wrong!"
      redirect_to root_path 
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
