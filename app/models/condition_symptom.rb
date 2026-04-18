class ConditionSymptom < ApplicationRecord
  belongs_to :condition
  belongs_to :symptom
end
