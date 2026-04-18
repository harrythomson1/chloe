class Condition < ApplicationRecord
  has_many :condition_symptoms
  has_many :symptoms, through: :condition_symptoms
  has_many :user_conditions
end
