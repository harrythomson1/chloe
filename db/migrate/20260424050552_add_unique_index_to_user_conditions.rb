class AddUniqueIndexToUserConditions < ActiveRecord::Migration[8.1]
  def change
    add_index :user_conditions, [:user_id, :condition_id], unique: true
  end
end
