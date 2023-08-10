require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :feedbacks, only: %i[index edit update show]

  devise_for :users, skip: [:registrations], controllers: { invitations: 'invitations' }
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  # Root
  root to: 'landing#index'
  # Shortcuts
  get 'landing/index'

  resources :profiles, only: %i[show edit update]

  resources :pair_requests, except: %i[new edit update] do
    scope module: :pair_requests do
      resources :acceptances, only: :create
      resources :completions, only: :create
      resources :rejections, only: :create
      resources :cancellations, only: :create
    end
  end

  resources :standup_meeting_groups do
    scope module: :standup_meeting_groups do
      resources :joins, only: %i[create destroy]
    end

    resources :standup_meetings, only: %i[index create edit update] do
      scope module: :standup_meetings do
        resources :skips, only: :create
        resources :completions, only: :create
      end
    end
  end

  resources :blogs, only: :show, param: :user_id
  resources :blog_posts, except: :index

  scope controller: :static do
    get :faq
  end
end
