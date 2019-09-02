Rails.application.routes.draw do 
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/' => 'devise/sessions#new'
    get '/sign_in' => 'devise/sessions#new'
  end

  resources :home do
    collection do
      get 'user_configuration'
      get 'finish'
    end
    put 'update_user'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :home, only: [:index]
    resources :configurations, only: [:index]
    resources :events
    resources :documents
    resources :category_events
    resources :countries
    resources :tutorials
    resources :users do
      member do
        put "change_user_role"
        get "edit_admin"
        get "edit_admin_password"
        get "edit_password"
        put "update_admin"
        delete "destroy_admin"
      end
      collection do 
        get "admins"
        get "new_admin"
        post "create_admin"
      end
    end
    resources :assignations
  end

  # API
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :events, only: [:index]
      resources :documents, only: [:index]
      resources :tutorials, only: [:index]
      resources :users, only: [:index] do
        collection do
          get "get_user"
          get "get_countries"
          get "create_user"
          get "assign_user"
          get "save_url_chat"
          get "validate_social"
          get "forgot_password"
          get "user_profile"
          get "user_update"
        end
      end
      resources :countries, only: [:index]
    end
  end
end
