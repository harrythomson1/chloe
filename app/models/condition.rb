class Condition < ApplicationRecord
  has_many :user_conditions, dependent: :destroy
  validates :source_url, uniqueness: true
end
