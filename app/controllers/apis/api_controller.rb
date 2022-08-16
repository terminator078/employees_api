class Apis::ApiController < ApplicationController

private
def is_authenticated
  data = decode(token)
  if !data.present? && !match_credentials(data['email'],data['password_digest'])
    head :unauthorized
  end
end

def token
  request.params['token'].to_s

end

def decode(token)
  begin
    data = JWT.decode token, Rails.application.secrets.secret_key_base, 'HS256'
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    head :unauthorized
  end

  data[0]
end

def match_credentials(email, password)
  if email.present?
    employee = Employee.find_by(email: email)
    if employee.password_digest == password
      return true
    end
  end

  false
end


end