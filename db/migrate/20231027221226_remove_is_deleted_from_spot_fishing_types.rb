class RemoveIsDeletedFromSpotFishingTypes < ActiveRecord::Migration[7.0]
  def change
    remove_column :spot_fishing_types, :is_deleted, :boolean
  end
end
