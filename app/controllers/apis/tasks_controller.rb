class Apis::TasksController < Apis::ApiController
  before_action :is_authenticated, only: [:create, :update, :destroy]

  def create
    if is_valid_status && is_authorized(permitted_params[:employee_id])
      @employee = Employee.find(permitted_params[:employee_id])
      @task = @employee.tasks.new(permitted_params.except(:token))
      if @task.save
        render json: {status: 'task_created', task: @task}, status: :ok
        return
      end
    end
    render json: {status: 'error'}, status: :unprocessable_entity
  end

  def update
    if is_valid_status && is_authorized(permitted_params[:employee_id])
      @employee = Employee.find(permitted_params[:employee_id])
      @task = @employee.tasks.find(permitted_params[:id])
      if @task.update(permitted_params.except(:token, :id))
        render json: {status: 'task_updated', task: @task}, status: :ok
        return
      end
    end
    render json: {status: 'error'}, status: :unprocessable_entity
  end

  def destroy
    if is_valid_status && is_authorized(permitted_params[:employee_id])
      @employee = Employee.find(permitted_params[:employee_id])
      @task = @employee.tasks.find(permitted_params[:id])
      if @task.destroy
        render json: {status: 'task_deleted', task: @task}, status: :ok
        return
      end
    end
    render json: {status: 'error'}, status: :unprocessable_entity
  end

  private


  def permitted_params
    params.permit(:id, :employee_id, :task, :status, :token)
  end

  def is_valid_status
    if permitted_params[:status] == 'in_progress' ||
      permitted_params[:status] == 'ready_for_qa' ||
      permitted_params[:status] == 'ready_for_dev'
      return true
    end

    false
  end

end