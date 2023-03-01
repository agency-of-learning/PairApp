Rails.application.routes.draw do
  get 'landing/index'
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
  
  root "landing#index"
end
