class AddDescriptionToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :description, :string
  end
end
