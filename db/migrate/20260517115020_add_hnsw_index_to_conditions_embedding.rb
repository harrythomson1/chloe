class AddHnswIndexToConditionsEmbedding < ActiveRecord::Migration[8.1]
  def change
    add_index :conditions, :embedding,
      using: :hnsw,
      opclass: :vector_cosine_ops
  end
end
