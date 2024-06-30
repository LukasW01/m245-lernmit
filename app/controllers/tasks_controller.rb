class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    if can? :create, Task
      build_task
    else
      head :forbidden
    end
  end

  def create
    if can? :create, Task
      build_task
      save_task(event: 'task:created', form: 'new')
    else
      head :forbidden
    end
  end

  def edit
    if can? :update, Task
      load_task
      build_task
    else
      head :forbidden
    end
  end

  def update
    if can? :update, Task
      load_task
      build_task
      save_task(form: 'edit')
    else
      head :forbidden
    end
  end

  def show
    load_task
  end

  def index
    load_tasks
  end

  def destroy
    if can? :destroy, Task
      load_task
      if @load_task.destroy
        up.layer.emit('task:destroyed')
        redirect_to tasks_path
      else
        redirect_to @load_task, alert: 'Could not delete task'
      end
    else
      head :forbidden
    end
  end

  def filter
    if %w[upcoming completed].include?(params[:status].to_s)
      @load_tasks = task_scope.where(status: params[:status]).to_a
    elsif %w[past_due].include?(params[:status].to_s)
      @load_tasks = task_scope.where('due_date < ?', Time.now).where(status: 'upcoming').to_a
    end
    render :index
  end

  private

  def load_tasks
    @load_tasks ||= task_scope.order(created_at: :desc).to_a
  end

  def task_scope
    Task.where(user_id: current_user.id)
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
