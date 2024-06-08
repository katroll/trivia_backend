class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:user][:username])

    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      render json: { session: user.id, user: user.to_json }, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def logged_in
    user = User.find_by(id: params[:user_id])
    if user
      render json: {
        logged_in: true,
        user: user
      }, status: :ok
    else
      render json: {
        logged_in: false
      }, status: :not_found
    end
  end

  def logout
    reset_session
    render json: { 
      status: 200, 
      logged_out: true 
    }
  end
end