class AddUniquenessToFishName < ActiveRecord::Migration[7.0]
  def change
    change_column :fish, :name, :string, unique: true
  end
end
