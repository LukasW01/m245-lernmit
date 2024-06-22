module TasksHelper
  def load_tasks(view)
    @load_tasks ||= task_scope.where(due_date: start_date(view)..end_date(view)).order(created_at: :desc).to_a
  end

  private

  def task_scope
    Task.where(user_id: current_user.id, types: 'Exam')
  end

  def start_date(view)
    if view == 'month'
      params[:start_date].present? ? params[:start_date].to_date.beginning_of_month : Date.today.beginning_of_month
    elsif view == 'week'
      params[:start_date].present? ? params[:start_date].to_date.beginning_of_week : Date.today.beginning_of_week
    end
  end

  def end_date(view)
    if view == 'month'
      start_date(view).end_of_month
    elsif view == 'week'
      start_date(view).end_of_week
    end
  end
end
