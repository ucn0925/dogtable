class RenameCommentsToPosts < ActiveRecord::Migration[7.1]
  def change
    rename_table :comments, :posts
  end
end
