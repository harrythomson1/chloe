class CreateMedications < ActiveRecord::Migration[8.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :rx_norm_id

      t.timestamps
    end
  end
end
