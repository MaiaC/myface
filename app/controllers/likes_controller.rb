class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(likeable_id: params[:id], likeable_type: params[:type])
    if @like.save
      flash[:success] = "You liked something!"
      redirect_to root_path 
    else
      flash[:alert] = "Something went wrong!"
      redirect_to root_path 
    end
  end

  def destroy
    @like = Like.find_by(likeable_id: params[:id], user_id: current_user.id)
    @like.destroy
    flash[:success] = "You unliked something!"
    redirect_to root_path
  end
end
