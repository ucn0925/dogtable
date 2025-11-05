class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @posts = @user.posts.includes(:shop)
    @favorites = @user.shop_favorites.includes(:shop)
  end
end
