class Apis::EmployeesController < Apis::ApiController
  before_action :is_authenticated, only: [:index, :update, :destroy]

    def index
      if is_authorized(permitted_params[:id])
      @employees = Employee.order('created_at')
      @tasks = {}
      @employees.each do |employee|
        @tasks[employee.id] = Task.where(employee_id: employee.id)
      end
      render :index, status: :ok
      return
      end
      render json: {status: 'error'}, status: :unauthorized
    end

  def update
    if is_authorized(permitted_params[:id])
      @employee = Employee.find(permitted_params[:id])
      if @employee.update(permitted_params.except(:token))
        render json: {status: 'updated'}, status: :ok
        return
      end
      render json: {status: 'error'}, status: :unprocessable_entity
    elsif
    render json: {status: 'error'}, status: :unauthorized
    end
  end

  def destroy
    if is_authorized(permitted_params[:id])
    @employee = Employee.find(permitted_params[:id])
    if @employee.destroy
    render json: {status: 'deleted'}, status: :ok
    elsif
    render json: {status: 'error'}, status: :unprocessable_entity
    end
    end
  end

  private

  def permitted_params
    params.permit(:id, :token, :name, :role, :team_number, :mobile, :email)
  end

end
