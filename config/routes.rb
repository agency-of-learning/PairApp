Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
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
    resources :rejections, only: :create
  end
end
