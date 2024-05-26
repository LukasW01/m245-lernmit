class User < ApplicationRecord
  include Clearance::User

  has_many :tasks, dependent: :destroy
end
