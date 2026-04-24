class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_conditions, dependent: :destroy
  has_many :conditions, through: :user_conditions
  has_many :user_medications, dependent: :destroy
  has_many :medications, through: :user_medications
end
