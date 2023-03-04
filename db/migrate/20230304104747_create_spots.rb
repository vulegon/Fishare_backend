class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots, id: :uuid do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
