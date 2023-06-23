require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :feedbacks, only: %i[edit update show]

  devise_for :users, skip: [:registrations], controllers: { invitations: 'invitations' }
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  # Root
  root to: 'landing#index'
  # Shortcuts
  get 'landing/index'

  resources :pair_requests, except: %i[new edit update] do
    scope module: :pair_requests do
      resources :acceptances, only: :create
      resources :completions, only: :create
      resources :rejections, only: :create
      resources :cancellations, only: :create
    end
  end

  resources :standup_meeting_groups do
    resources :standup_meetings, only: %i[edit update] do
      scope module: :standup_meetings do
        resources :skips, only: :create
      end
    end
  end
end
