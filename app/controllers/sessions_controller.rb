class SessionsController < ApplicationController

  def create
      user = User.find_by(username: params[:username])
      
      if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: {session: user.id, user: user.to_json}, status: :created
      else
          render json: { error: "Invalid username or password", params: params }, status: :unauthorized
      end
  end

  def destroy
      session.delete :user_id
      head :no_content
  end
end