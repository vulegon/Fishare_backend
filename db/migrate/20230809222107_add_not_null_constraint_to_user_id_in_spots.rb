class AddNotNullConstraintToUserIdInSpots < ActiveRecord::Migration[7.0]
  def change
    change_column_null :spots, :user_id, false
  end
end
