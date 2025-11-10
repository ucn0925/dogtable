class PostsController < ApplicationController
  def create
    @shop = Shop.find(params[:shop_id])
    @post = @shop.posts.build(post_params)
    @post.user = current_user

    if @post.save 
      redirect_to shop_path(@shop), notice: "コメントを投稿しました。"
    else
      redirect_to shop_path(@shop), alert: "コメントを投稿できませんでした。"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to shop_path(@post.shop), notice: "コメントを削除しました。"
    else
      redirect_to shop_path(@post.shop), alert: "削除権限がありません。"
    end
  end

  def edit
    @shop = Shop.find(params[:shop_id])
    @post = @shop.posts.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:shop_id])
    @post = @shop.posts.find(params[:id])

    if params[:post][:images].present? && params[:post][:images].reject(&:blank?).empty?
      params[:post].delete(:images)
    end

    if @post.update(post_params)
      redirect_to shop_path(@shop), notice: "コメントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @post = @shop.posts.build
  end

  private

  def post_params
    params.require(:post).permit(
      :content,
      :rating_overall,
      :rating_food,
      :rating_dog_friendliness,
      :dog_size,
      :visited_on,
      images: []
      )
  end
end
