class Symptom < ApplicationRecord
  has_many :condition_symptoms
  has_many :conditions, through: :condition_symptoms
end
