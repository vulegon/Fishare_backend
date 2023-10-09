class CreateSpotFishingTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :spot_fishing_types, id: :uuid do |t|
      t.uuid :spot_id, null: false
      t.uuid :fishing_type_id, null: false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end

    add_foreign_key :spot_fishing_types, :spots, column: :spot_id, type: :uuid
    add_foreign_key :spot_fishing_types, :fishing_types, column: :fishing_type_id, type: :uuid
  end
end
