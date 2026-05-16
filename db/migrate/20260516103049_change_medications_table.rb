class ChangeMedicationsTable < ActiveRecord::Migration[8.1]
  def change
    remove_column :medications, :rx_norm_id, :string
    add_column :medications, :source_url, :string
    add_index :medications, :source_url, unique: true
  end
end
