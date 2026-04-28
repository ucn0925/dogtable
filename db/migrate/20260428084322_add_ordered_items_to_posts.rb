class AddOrderedItemsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :ordered_items, :text
  end
end
