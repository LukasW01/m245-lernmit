class AchievementsController < ApplicationController
  before_action :require_login
  def index
    load_achievements
  end

  private

  def achievements_scope
    AchievementsUser.where(user_id: current_user.id)
  end

  def load_achievements
    @load_achievements ||= achievements_scope.to_a
  end
end
