# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'

  before_action :configure_sign_up_params, only: [:create], if: :devise_controller?
  before_action :xero_client

  def home; end

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

  def refresh_token
    @token_set = @xero_client.refresh_token_set(current_user.user_token.token_set)
    current_user.user_token.token_set = @token_set unless @token_set['error']
    current_user.user_token.token_set['connections'] = @xero_client.connections
    current_user.user_token.save!
    flash.notice = 'Successfully Refreshed Token'
    redirect_to root_url
  end

  def revoke_token
    @xero_client.revoke_token(current_user.user_token.token_set)
    current_user.user_token.token_set = nil
    current_user.user_token.save!
    flash.notice = 'Successfully Revoked Token'
    redirect_to root_url
  end

  def change_organisation
    current_user.user_token.active_tenant_id = params['change_organisation']['active_tenant_id']
    current_user.user_token.save!
    flash.notice = "Current Tenant/Org updated #{current_user.user_token.active_tenant_id}"
    redirect_to root_url
  end

  def disconnect
    remaining_connections = @xero_client.disconnect(params[:connection_id])
    current_user.user_token.token_set['connections'] = remaining_connections
    current_user.user_token.active_tenant_id = latest_connection(current_user.user_token.token_set['connections'])
    current_user.user_token.save!
    flash.notice = "Removed #{current_user.user_token.active_tenant_id}"
    redirect_to root_url
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
    current_user.user_token.token_set['connections'] = @xero_client.connections
    current_user.user_token.active_tenant_id = latest_connection(current_user.user_token.token_set['connections'])
  end
end
