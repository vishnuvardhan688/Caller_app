Rails.application.routes.draw do
  root "home#index"

  # resources :account
  # resources :user
  resources :contact

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  get "/signout" => "sessions#destroy", as: :destroy_session

  get "dashboard" => "dashboard#index", as: :dashboard
  post "token/generate" => "token#generate"
  post "call/connect" => "call#connect"
  post "call/record_call" => "call#record_call"

  resources :tickets, only: [:create]
end
