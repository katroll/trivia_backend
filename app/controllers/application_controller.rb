class ApplicationController < ActionController::Base
  include ActionController::Cookies
  # protect_from_forgery unless: -> { request.format.json? }
  # skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  
  def csrf_token
    render json: { csrfToken: form_authenticity_token }
  end
end
