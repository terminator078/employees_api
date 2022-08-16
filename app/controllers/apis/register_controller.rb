class Apis::RegisterController < ApplicationController

  def create
    data = {email: permitted_params[:email], password_digest: permitted_params[:password_digest]}
    token = encode(data)
    object = permitted_params
    object[:auth_token] = token
    @employee = Employee.new(object)
    if is_valid_role && @employee.save
      render json: {status: 'created', id: @employee.id, token: token}, status: :created
    else
      render json: {status: 'not_created'}, status: :unauthorized
    end
  end

  private
  def permitted_params
    params.permit(:name, :email, :password_digest, :team_number, :role, :mobile)
  end

  def is_valid_role
    if permitted_params[:role] == 'FrontEnd' || permitted_params[:role] == 'BackEnd'
      return true
    end

    false
  end

end