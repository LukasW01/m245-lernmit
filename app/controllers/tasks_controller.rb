class TasksController < ApplicationController
  def new
    build_task
  end

  def create
    build_task
    save_task(event: 'task:created', form: 'new')
  end

  def edit
    load_task
    build_task
  end

  def update
    load_task
    build_task
    save_task(form: 'edit')
  end

  def show
    load_task
  end

  def index
    load_tasks
  end

  def destroy(event: nil)
    load_task
    if @load_task.destroy
      up.layer.emit(event) if event
      redirect_to @load_task, notice: 'Task deleted successfully'
    else
      redirect_to @load_task, alert: 'Could not delete task'
    end
  end

  def filter_status
    if %w[upcoming completed].include?(params[:status].to_s)
      @load_tasks = task_scope.where(status: params[:status]).to_a
    elsif %w[upcoming].include?(params[:status].to_s)
      @load_tasks = task_scope.where('due_date < ?', Date.today).where(status: 'upcoming').to_a
    end
    render :index
  end

  private

  def load_tasks
    @load_tasks ||= task_scope.order(created_at: :desc).to_a
  end

  def task_scope
    current_tenant.tasks
  end

  def load_task
    @load_task ||= task_scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :index, alert: 'Task not found'
  end

  def build_task
    @load_task ||= task_scope.build
    @load_task.attributes = task_attributes
  end

  def save_task(form:, event: nil)
    if up.validate?
      @load_task.valid?
      render form
    elsif @load_task.save
      up.layer.emit(event) if event
      redirect_to @load_task, notice: 'Task saved successfully'
    else
      render form, status: :bad_request
    end
  end

  def task_attributes
    if (attrs = params[:task])
      attrs.permit(:title, :text, :types, :status, :due_date, :points)
    else
      {}
    end
  end
end
