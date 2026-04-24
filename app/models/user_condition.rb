class UserCondition < ApplicationRecord
  belongs_to :user
  belongs_to :condition
  validates :condition_id, uniqueness: { scope: :user_id }
end
