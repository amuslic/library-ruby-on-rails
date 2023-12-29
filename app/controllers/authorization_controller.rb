require 'jwt'

class AuthorizationController < ApplicationController
  before_action :find_user, only: :login

  def login
    if @user&.authenticate(params[:password])
      token = encode_token(user_payload)
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def find_user
    @user = User.find_by(username: params[:username])
  end

  def user_payload
    { user_id: @user.id, role: @user.role }
  end

  def encode_token(payload)
    secret_key = Rails.application.secrets.secret_key_base || 'your_default_secret_key'
    JWT.encode(payload, secret_key, 'HS256')
  end
end
