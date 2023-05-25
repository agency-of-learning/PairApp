require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, skip: [:registrations], controllers: { invitations: 'invitations' }
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  # Root
  root to: 'landing#index'
  # Shortcuts
  get 'landing/index'

  resources :pair_requests, except: %i[edit update]

  namespace :pair_requests do
    resources :acceptances, only: :create
    resources :completions, only: :create
    resources :rejections, only: :create
  end
end
