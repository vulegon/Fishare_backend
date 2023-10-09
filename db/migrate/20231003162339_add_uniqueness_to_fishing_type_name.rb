class AddUniquenessToFishingTypeName < ActiveRecord::Migration[7.0]
  def change
    change_column :fishing_types, :name, :string, unique: true
  end
end
