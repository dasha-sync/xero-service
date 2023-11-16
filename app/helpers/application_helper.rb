# frozen_string_literal: true

module ApplicationHelper
  require 'jwt'

  CREDS = {
    client_id: ENV.fetch('CLIENT_ID', nil),
    client_secret: ENV.fetch('CLIENT_SECRET', nil),
    redirect_uri: ENV.fetch('REDIRECT_URI', nil),
    scopes: ENV.fetch('SCOPES', nil),
    state: 'this is area for customer state param'
  }.freeze

  CONFIG = { timeout: 30, debugging: true }.freeze

  def token_expired
    xero_client.token_expired?
  end

  def id_token
    JWT.decode(current_user.user_token.token_set['id_token'], nil, false)[0] if current_user&.user_token&.token_set
  end

  def access_token
    JWT.decode(current_user.user_token.token_set['access_token'], nil, false)[0] if current_user&.user_token&.token_set
  end

  def xero_client
    @xero_client ||= XeroRuby::ApiClient.new(credentials: CREDS, config: CONFIG)

    @xero_client.set_token_set(current_user.user_token.token_set) if current_user&.user_token&.token_set

    @xero_client
  end

  def authorization_url
    @authorization_url ||= xero_client.authorization_url
  end
end
