class Apis::LoginController < ApplicationController

  def index
    begin
    employee = Employee.find_by(email: permitted_params[:email])
    if employee[:password_digest] == (permitted_params[:password_digest])
      if is_token_valid(employee.auth_token)
        render json: {status: 'logged_in', id: employee.id, token: employee.auth_token}, status: :ok
        return
      elsif
        data = {email: permitted_params[:email], password_digest: permitted_params[:password_digest]}
        token = encode(data)
        employee.update(auth_token: token)
        render json: {status: 'logged_in', id: employee.id, token: token}, status: :ok
        return
      end
    end
    rescue
    render json: {status: 'invalid_credentials'}, status: :unauthorized
    end
  end


  private
  def permitted_params
    params.permit( :password_digest,:email)
  end

end