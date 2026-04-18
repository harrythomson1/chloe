class CreateConditionSymptoms < ActiveRecord::Migration[8.1]
  def change
    create_table :condition_symptoms do |t|
      t.references :condition, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
