# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, only: [:create], if: :devise_controller?

  protected

  def configure_sign_up_params
    attributes = %i[username email password password_confirmation user_token_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end
end
