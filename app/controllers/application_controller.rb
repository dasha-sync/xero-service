# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'

  before_action :configure_sign_up_params, only: [:create], if: :devise_controller?
  before_action :xero_client

  def callback
    if params['code'] && current_user
      init_token_set(params)

      flash.notice = if current_user.user_token.save
                       'Successfully received Xero Token Set and saved to user'
                     else
                       "Successfully received Xero Token Set and don't saved"
                     end
    else
      flash.notice = 'Failed to received Xero Token Set'
    end
  end

  protected

  def configure_sign_up_params
    attributes = %i[username email password password_confirmation user_token_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

  private

  def init_token_set(params)
    @token_set = @xero_client.get_token_set_from_callback(params)
    current_user.user_token.token_set = @token_set unless @token_set[:error]
  end
end
