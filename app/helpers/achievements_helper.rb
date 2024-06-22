module AchievementsHelper
  def achievements
    @achievements ||= Achievement.all.to_a
  end
end
