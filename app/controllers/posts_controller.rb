class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path 
    else
      render "static_pages/home" 
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:user_id, :body)
    end
end
