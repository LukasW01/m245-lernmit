class CalenderController < ApplicationController
  before_action :require_login
  def index
    load_tasks
  end

  def week
    load_tasks
    render :week
  end

  def month
    load_tasks
    render :month
  end

  private

  def load_tasks
    @load_tasks ||= task_scope.order(created_at: :desc).to_a
  end

  def task_scope
    Task.where(user_id: current_user.id)
  end
end
