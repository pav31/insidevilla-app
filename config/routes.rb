Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/robots.:format', to: 'welcome#robots'

  scope "(:locale)", locale: /ru|en/ do
    root to: 'welcome#index'
    get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
    resources :static_pages, only: :show
    resources :subscriptions, only: [:create, :destroy] do
      get :unsubscribe, on: :member
    end
    resources :estates, only: %i[index show]  do
      resources :bookings, only: %i[new create]
      collection do
        # todo: uncomment following when using POST for search
        # match 'search' => 'estates#search', via: %i[get post], as: :search
        get 'reset_filter' => 'estates#reset_filter', via: :get, as: :reset_filter
      end
    end

    get 'feedbacks', action: :index, controller: :feedbacks
    resources :estates, only: :show do
      resources :feedbacks, only: %i[index show new create]
    end

    match '/contact', to: 'contacts#new', via: 'get'
    resource :contacts, only: %i[new create]
    match '/promo_mailer', to: 'promro_mailer#new', via: 'get'
    resource :promo_mailers, only: %i[new create]

    authenticate :user do
      mount Sidekiq::Web => '/sidekiq'

      resources :settings, only: [] do
        delete :reset, on: :collection
      end

      resources :estates
      resources :estates do
        resources :bookings
      end
      resources :comforts, :images
    end
  end
end
