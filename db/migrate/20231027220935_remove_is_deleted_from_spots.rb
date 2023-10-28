class RemoveIsDeletedFromSpots < ActiveRecord::Migration[7.0]
  def change
    remove_column :spots, :is_deleted, :boolean
  end
end
