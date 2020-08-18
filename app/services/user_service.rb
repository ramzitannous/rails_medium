# frozen_string_literal: true

require 'jwt'
require_relative '../exceptions'

class UserService
  AUTHORIZATION_HEADER_NAME = 'HTTP_AUTHORIZATION'

  def initialize(name, password)
    @name = name
    @password = password
  end

  def authenticate
    @user = User.find_by!(name: @name)
    raise AppExceptions::UnAuthorized unless @user.authenticate(@password)

    generate_token
  end

  def self.check_request(headers = {})
    raise AppExceptions::UnAuthorized, 'Credentials were not provided' unless headers.key?(AUTHORIZATION_HEADER_NAME)

    token = headers[AUTHORIZATION_HEADER_NAME]
    user_id = decode_token(token)
    User.find_by!(id: user_id)
  end

  def self.decode_token(token)
    decoded_token = JWT.decode(token, Rails.application.secret_key_base)
    decoded_token[0]['user_id']
  rescue JWT::DecodeError => e
    raise AppExceptions::UnAuthorized, e.message
  end

  private

  def create_payload
    {
      user_id: @user.id.to_s,
      exp: 24.hours.from_now.to_i,
      username: @user.name
    }
  end

  def generate_token
    payload = create_payload
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
