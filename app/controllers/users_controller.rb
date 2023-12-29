class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    @users_api_models = @users.map { |user| UserApiModel.new(user) }
    render json: @users_api_models
  end

  # GET /users/1
  def show
    @users_api_model =  UserApiModel.new(@user) 
    render json: @users_api_model
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password_digest)
    end
end
