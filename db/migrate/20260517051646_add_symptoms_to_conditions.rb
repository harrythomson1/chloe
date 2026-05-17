class AddSymptomsToConditions < ActiveRecord::Migration[8.1]
  def change
    add_column :conditions, :symptoms, :text
    drop_table :condition_symptoms
    drop_table :symptoms
  end
end
