class PostFavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_shop_and_post

    def create
        current_user.post_favorites.create(post: @post)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_back fallback_location: shop_post_path(@shop, @post) }
        end
    end

    def destroy
        favorite = current_user.post_favorites.find_by(post: @post)
        favorite&.destroy
        
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_back fallback_location: shop_post_path(@shop, @post) }
        end
    end

    private

    def set_shop_and_post
        @shop = Shop.find(params[:shop_id])
        @post = @shop.posts.find(params[:post_id])
    end
end
