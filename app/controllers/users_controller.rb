class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @feed_items = @user.posts
    @comment = Comment.new
    @friends = @user.friends
  end
end
