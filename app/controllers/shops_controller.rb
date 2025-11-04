class ShopsController < ApplicationController

  before_action :authenticate_user!

  def index
    @shops = Shop.all
    @area_options = []

    Block.all.each do |block|
      @area_options << [block.name, "block_#{block.id}"]

      block.cities.each do |city|
        @area_options << [" ├ #{city.name}", "city_#{city.id}"]
      end
    end

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

  def show
    @shop = Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)

    if @shop.save
      redirect_to new_shop_path, notice: "お店を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      redirect_to @shop, notice: "店鋪情報を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to shops_path, notice: "店舗を削除しました！"
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :address, :genre_id, :city_id, :block_id, images: [])
  end
end
