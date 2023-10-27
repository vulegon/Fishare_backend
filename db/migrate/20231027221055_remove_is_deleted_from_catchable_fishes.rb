class RemoveIsDeletedFromCatchableFishes < ActiveRecord::Migration[7.0]
  def change
    remove_column :catchable_fishes, :is_deleted, :boolean
  end
end
