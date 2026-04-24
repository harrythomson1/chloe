class UserMedication < ApplicationRecord
  belongs_to :user
  belongs_to :medication
  validates :medication_id, uniqueness: { scope: :user_id }
end
