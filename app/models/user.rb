class User < ApplicationRecord
  include Clearance::User

  has_many :tasks, dependent: :destroy
  has_many :achievements_users, dependent: :destroy
end
