class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots, id: :uuid do |t|
      t.string :name, null:false
      t.float :latitude, limit: 53, null: false
      t.float :longitude, limit: 53, null: false
      t.string :description
      t.uuid :user_id
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end

    add_foreign_key :spots, :users, column: :user_id, type: :uuid
  end
end
