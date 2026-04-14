class AddVisitSceneAndMenusToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :visit_scene, :integer
    add_column :posts, :ordered_menu, :text
    add_column :posts, :ordered_dog_menu, :text
  end
end
