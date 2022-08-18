class Task < ApplicationRecord
  belongs_to :employee

  validates :task, presence: true, uniqueness: true
  validates :status, presence: true
end
