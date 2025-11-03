class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @comments = @user.comments.includes(:shop)
    @favorites = @user.shop_favorites.includes(:shop)
  end
end
