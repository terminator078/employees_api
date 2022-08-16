class ApplicationController < ActionController::API

  private
  def encode(data)
    data[:exp] = (Time.zone.now + 1.days).to_i
    token = JWT.encode data, Rails.application.secrets.secret_key_base, 'HS256'

    token
  end

  def is_token_valid(token)
    begin
      JWT.decode token, Rails.application.secrets.secret_key_base, 'HS256'
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      return false
    else
      return true
    end
  end

  def is_authorized(id)
    begin
      employee = Employee.find(id)
      if employee.role == 'LeadManager' || employee.role == 'Manager'
        return true
      elsif employee.id == id.to_i
        return true
      end
    rescue
      return false
    end

    false
  end

end
