class AddLocationToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :location_id, :uuid, null: false
    add_foreign_key :spots, :locations, column: :location_id, type: :uuid
  end
end
