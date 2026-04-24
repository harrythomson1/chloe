class AddUniqueIndexToUserMedications < ActiveRecord::Migration[8.1]
  def change
    add_index :user_medications, [:user_id, :medication_id], unique: true
  end
end
