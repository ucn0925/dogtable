class AddDogSizeToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :dog_size, :string
  end
end
