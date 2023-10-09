class CreateCatchableFishes < ActiveRecord::Migration[7.0]
  def change
    create_table :catchable_fishes, id: :uuid do |t|
      t.uuid :spot_id, null: false
      t.uuid :fish_id, null: false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end

    add_foreign_key :catchable_fishes, :spots, column: :spot_id, type: :uuid
    add_foreign_key :catchable_fishes, :fish, column: :fish_id, type: :uuid
  end
end
