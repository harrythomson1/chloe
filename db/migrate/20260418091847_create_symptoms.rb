class CreateSymptoms < ActiveRecord::Migration[8.1]
  def change
    create_table :symptoms do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
