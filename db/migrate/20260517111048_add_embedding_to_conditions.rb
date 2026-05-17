class AddEmbeddingToConditions < ActiveRecord::Migration[8.1]
  def change
    add_column :conditions, :embedding, :vector, limit: 756
  end
end
