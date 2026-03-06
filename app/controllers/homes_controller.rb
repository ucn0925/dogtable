class HomesController < ApplicationController
  def top
    @area_options = []

    Block.all.each do |block|
      @area_options << [block.name, "block_#{block.id}"]

      block.cities.each do |city|
        @area_options << [" ├ #{city.name}", "city_#{city.id}"]
      end
    end

    @recent_posts = Post.includes(:shop, :user).order(created_at: :desc).limit(5)
  end
end
