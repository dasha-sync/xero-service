# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, path: '', controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  ## Xero
  # authentication routes
  get '/callback', to: 'application#callback'
  get '/refresh_token', to: 'application#refresh_token'
  get '/revoke_token', to: 'application#revoke_token'
  get '/change_organisation', to: 'application#change_organisation'
  get '/disconnect', to: 'application#disconnect'
  get '/application/home', to: 'application#home'
end
