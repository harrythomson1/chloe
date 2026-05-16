class AddUniqueIndexToCondtionsSourceUrl < ActiveRecord::Migration[8.1]
  def change
    add_index :conditions, :source_url, unique: true
  end
end
