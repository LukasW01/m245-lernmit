class Task < ApplicationRecord
  belongs_to :tenant

  validates :title, :text, :types, :due_date, :points, presence: true
  validates :points, numericality: { only_integer: true, greater_than: 0 }
  validates :types, inclusion: { in: %w[Task Exam] }
  validates :due_date, date: { after: proc { Date.today }, message: 'must be in the future' }

  scope :status, -> { where(status: true) }

  has_defaults status: false

  def toggle_status!
    update!(status: !status?)
  end

  def self.clear_status!
    where(status: true).destroy_all
  end
end
