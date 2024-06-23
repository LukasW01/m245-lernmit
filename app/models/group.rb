class Group < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at desc id name size updated_at]
  end
end
