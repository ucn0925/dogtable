class ChangeDogSizeToIntegerInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :dog_size, :integer
  end
end
