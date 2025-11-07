class AddDogacilitiesToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :inside_ok, :boolean
    add_column :shops, :terrace_ok, :boolean
    add_column :shops, :dog_menu, :boolean
    add_column :shops, :lead_hook, :boolean
  end
end
