Rails.application.routes.draw do
  # Shortcuts
  get 'landing/index'
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
  
  # Alphabetized Routes
  resources :pair_requests do
    delete '/acceptances', to: 'acceptances#destroy', as: 'acceptances_destroy'
    get "add_feedback", to: "pair_requests#add_feedback"


    resources :acceptances, only: [:create]
  end

  
  resources :users, only: [:show, :edit, :update] do 
    get 'my_pairings', to: 'users#my_pairings', as: 'my_pairings'
  end
  

  # Root  
  root "landing#index"
end
