class UsersController < ApplicationController
  def favorites
    @user = User.find(params[:id])
    @favorite_shops = @user.favorite_shops
  end

  def show
    @user = User.find(params[:id])
    @favorite_shops = @user.favorite_shops
    @posts = @user.posts.includes(:shop)
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
end
