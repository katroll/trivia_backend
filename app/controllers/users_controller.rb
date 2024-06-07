class UsersController < ApplicationController
  before_action :set_user, only: %i[ update ]

  def show
    user = User.find_by(id: params["user_id"])
    if user
      render json: user
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :username, :password, :admin, :role)
  end
end
