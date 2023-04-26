Rails.application.routes.draw do
  devise_for :users
  # Root
  root to: 'landing#index'
  # Shortcuts
  get 'landing/index'
  
  # Alphabetized Routes
  # resources :pair_requests do
  #   resources :acceptances, only: [:create, :destroy]
  # end
end
