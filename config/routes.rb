Rails.application.routes.draw do
  # Shortcuts
  get 'landing/index'
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
  
  # Alphabetized Routes
  resources :pair_requests do
    delete '/acceptances', to: 'acceptances#destroy', as: 'acceptances_destroy'
    resources :acceptances, only: [:create]
  end
  resources :users, only: [:show, :edit, :update]

  # Root  
  root "landing#index"
end
