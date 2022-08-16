class Apis::LogoutController < ApplicationController

  def index
    begin
    employee = Employee.find(permitted_params[:id])
    if is_token_valid(permitted_params[:token]) && employee[:auth_token] == permitted_params[:token]
      employee.update(auth_token: nil)
      render json: {status: 'logged_out'}, status: :ok
      return
    elsif
    render json: {status: 'not_authorised'}, status: :unauthorized
    end
    rescue
    render json: {status: 'error'}, status: :unprocessable_entity
    end
  end


  private
  def permitted_params
    params.permit( :id, :token)
  end

end