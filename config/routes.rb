require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  # Root
  root to: 'landing#index'
  # Shortcuts
  get 'landing/index'

  # Alphabetized Routes
  # resources :pair_requests do
  #   resources :acceptances, only: [:create, :destroy]
  # end
end
