module StreakHelper
  def streak_daily
    dates = streak_scope.order(:created_at).pluck(:created_at).map(&:to_date)
    return 0 if dates.empty?

    dates.chunk_while { |i, j| i + 1 == j }.map(&:size).max
  end

  def streak_weekly
    dates = streak_scope.order(:created_at).pluck(:created_at).map(&:to_date)
    return 0 if dates.empty?

    # from monday to sunday of a week, if there is at least one day in the week
    # then the week is considered as a streak
    # if each week has at least one day, then the streak is the number of weeks
    dates.chunk_while { |i, j| i + 1 == j }.map(&:first).map(&:beginning_of_week).uniq.size
  end

  private

  def streak_scope
    Streak.where(user_id: current_user.id)
  end
end
