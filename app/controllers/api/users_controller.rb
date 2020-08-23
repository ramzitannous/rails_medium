# frozen_string_literal: true

require_relative '../../exceptions'
module Api
  class UsersController < ApplicationController
    skip_before_action :check_request_authorized?, only: %i[login create]

    def create
      user_params = user_create_param
      User.create!(user_params)
      render status: 201
    end

    def index
      users = User.all
      render json: users.to_json(except: :password_digest)
    end

    def login
      name, password = login_params
      user_service = UserService.new(name, password)
      token = user_service.authenticate
      render json: {
        token: token
      }
    end

    def me
      render json: @user.as_json(except: :password_digest)
    end

    def user_create_param
      field_names = %i[name password password_confirmation email]
      params.permit(field_names)
    end

    def login_params
      params.require(%w[name password])
    end
  end
end
