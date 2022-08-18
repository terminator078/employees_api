class Employee < ApplicationRecord
  has_many :tasks, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :mobile, presence: true
  validates :role, presence: true
  validates :team_number, presence: true
end
