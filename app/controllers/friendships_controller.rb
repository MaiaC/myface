class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy, :edit, :update]
  
  def index
    @pending_sent = current_user.pending_sent
    @pending_received = current_user.pending_received
    @users = User.all
  end
  
  def show

  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Friend request sent"
      redirect_to root_path
    else
      flash[:alert] = "Error sending friend request"
      redirect_to root_path
    end
  end

  def update
    @friendship.toggle(:accepted)
    if @friendship.save
      flash[:success] = "Friend request accepted"
      redirect_to friendships_path
    else
      flash[:alert] = "Error accepting friend request"
      redirect_to friendships_path
    end
  end

  def destroy
    @friendship.destroy
    flash[:success] = "Friendship destroyed"
    redirect_to friendships_path
  end

  private
  def set_friendship
    @friendship = current_user.friendships.find_by(friend_id: params[:id]) || current_user.inverse_friends.find_by(user_id: params[:id])
  end
end
