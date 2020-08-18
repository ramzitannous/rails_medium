# frozen_string_literal: true

require_relative '../exceptions'
class ApplicationController < ActionController::API
  rescue_from Mongoid::Errors::DocumentNotFound, with: :respond_not_found
  rescue_from AppExceptions::UnAuthorized, with: :respond_not_authorized

  attr_accessor :user

  before_action :check_request_authorized?

  private

  def respond_not_found
    render json: { details: :not_found }, status: :not_found
  end

  def respond_not_authorized(e)
    render json: { details: e.msg }, status: :unauthorized
  end

  def check_request_authorized?
    self.user = UserService.check_request(request.headers.to_h)
  end
end
