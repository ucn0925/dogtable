class RemoveOrderedMenuFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :ordered_menu, :string
    remove_column :posts, :ordered_dog_menu, :string
  end
end
