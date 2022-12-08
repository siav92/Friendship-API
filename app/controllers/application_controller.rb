# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :current_user

  def authorize_request
    find_current_user
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by!(email: token[:email])
  end
  alias find_current_user current_user

  private

  def token
    @token = begin
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      Registration::Token.decode_user_token(token)
    end
  end
end
