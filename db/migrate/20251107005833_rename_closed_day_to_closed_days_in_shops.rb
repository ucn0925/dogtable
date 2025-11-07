class RenameClosedDayToClosedDaysInShops < ActiveRecord::Migration[7.1]
  def change
    rename_column :shops, :closed_day, :closed_days
  end
end
