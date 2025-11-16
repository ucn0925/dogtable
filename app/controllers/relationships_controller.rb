class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to followings_user_path(current_user)
  end

  def destroy
    relationship = current_user.active_relationships.find(params[:id])
    relationship.destroy
    redirect_to followings_user_path(current_user)
  end
end
