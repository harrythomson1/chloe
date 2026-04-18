class CreateConditions < ActiveRecord::Migration[8.1]
  def change
    create_table :conditions do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :source_url

      t.timestamps
    end
  end
end
