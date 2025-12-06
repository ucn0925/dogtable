class ShopsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.all

    if params[:keyword].present?
      @shops = @shops.where("name LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:genre_id].present?
      @shops = @shops.where(genre_id: params[:genre_id])
    end

    if params[:area_id].present?
      type, id = params[:area_id].split('_')

      if type == "block"
        @shops = @shops.joins(:city).where(cities: { block_id: id})
      elsif type == "city"
        @shops = @shops.where(city_id: id)
      end
    end
  end

  def map
    @shops = Shop
             .joins(:genre)
             .select("shops.*, genres.name AS genre_name")
             .where.not(latitude: nil, longitude: nil)
  end

  def show
    @average_rating = @shop.posts.average(:rating_overall)&.round(1)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)

    if @shop.save
      redirect_to shop_path(@shop), notice: "お店を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:shop][:images].present? && params[:shop][:images].reject(&:blank?).present?
      @shop.images.attach(params[:shop][:images])
    end

    if @shop.update(shop_params.except(:images))
      redirect_to @shop, notice: "店鋪情報を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy_image
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_back(fallback_location: shop_path(image.record), notice: "画像を削除しました！")
  end

    def destroy
    @shop.destroy
    redirect_to shops_path, notice: "店舗を削除しました！"
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(
      :name, 
      :address, 
      :genre_id, 
      :city_id, 
      :block_id, 
      :inside_ok, 
      :terrace_ok, 
      :dog_menu, 
      :lead_hook,
      :opening_hours,
      :closed_days,
      :parking,
      :latitude,
      :longitude,
      images: [])
  end
end
