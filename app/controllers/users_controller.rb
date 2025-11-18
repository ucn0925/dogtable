class UsersController < ApplicationController
  def favorites
    @user = User.find(params[:id])
    @favorite_shops = @user.favorite_shops
  end

  def show
    @user = User.find(params[:id])
    @favorite_shops = @user.favorite_shops
    @posts = @user.posts.includes(:shop).order(created_at: :desc)
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    @relationships = current_user.active_relationships.index_by(&:followed_id)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
end
