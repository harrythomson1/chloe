class FixEmbeddingDimensions < ActiveRecord::Migration[8.1]
  def change
    remove_column :conditions, :embedding
    add_column :conditions, :embedding, :vector, limit: 768
  end
end
