class Task < ApplicationRecord
  belongs_to :tenant

  validates :title, :text, :types, :due_date, :points, presence: true
  validates :points, numericality: { only_integer: true, greater_than: 0 }
  validates :types, inclusion: { in: %w[Task Exam] }
  validates :due_date, date: { after: proc { Date.today }, message: 'must be in the future' }

  scope :status, -> { where(status: true) }

  has_defaults status: 'upcoming'
end
