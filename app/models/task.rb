class Task < ApplicationRecord
  belongs_to :tenant

  validates :title, :text, :types, :due_date, :points, presence: true
  validates :points, numericality: { only_integer: true, greater_than: 0 }
  validates :types, inclusion: { in: %w[Task Exam] }
  validates :due_date, date: { after: proc { Date.today }, message: 'must be in the future' }

  scope :done, -> { where(done: true) }

  has_defaults done: false

  def toggle_done!
    update!(done: !done?)
  end

  def self.clear_done!
    where(done: true).destroy_all
  end
end
