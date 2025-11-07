class AddDetailsToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :opening_hours, :string
    add_column :shops, :closed_day, :string
    add_column :shops, :parking, :boolean
  end
end
