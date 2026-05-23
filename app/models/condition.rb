class Condition < ApplicationRecord
  has_many :user_conditions, dependent: :destroy
  has_neighbors :embedding
  validates :source_url, uniqueness: true
end
