class AddVisitedOnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :visited_on, :date
  end
end
