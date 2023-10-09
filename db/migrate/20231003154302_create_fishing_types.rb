class CreateFishingTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_types, id: :uuid do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end
