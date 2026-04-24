class Symptom < ApplicationRecord
  has_many :condition_symptoms, dependent: :destroy
  has_many :conditions, through: :condition_symptoms
end
