class User < ApplicationRecord
  include Clearance::User

  has_many :tasks, dependent: :destroy
  has_many :achievement_users, dependent: :destroy
end
