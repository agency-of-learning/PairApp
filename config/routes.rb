require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  constraints(AdminConstraint) do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :feedbacks, only: %i[index edit update show]

  devise_for :users, controllers: {
    invitations: 'users/invitations',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

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

  resources :blogs, only: :show, param: :slug
  resources :blog_posts
  resources :featured_blog_posts, only: %i[index create update destroy]

  resources :user_mentee_applications, only: %i[index show new create edit update] do
    scope module: :user_mentee_applications do
      resources :acceptances, only: :create
      resources :rejections, only: :create
      resource :promotions, only: :create
    end
  end

  scope controller: :static do
    get :faq
  end
end
