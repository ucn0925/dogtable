class HomesController < ApplicationController
  def top
    @area_options = []

    Block.all.each do |block|
      @area_options << [block.name, "block_#{block.id}"]

      block.cities.each do |city|
        @area_options << [" ├ #{city.name}", "city_#{city.id}"]
      end
    end
  end
end
