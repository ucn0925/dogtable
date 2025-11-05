class AddRatingsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :rating_overall, :integer
    add_column :posts, :rating_food, :integer
    add_column :posts, :rating_dog_friendliness, :integer
  end
end
