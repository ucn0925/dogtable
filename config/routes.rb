Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:show] do
    resources :relationships, only: [:create, :destroy]
    get :favorites, on: :member
    member do
      get :followings
      get :followers
    end
  end

  resource :mypage, only: :show

  resources :shops, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :shop_favorite, only: [:create, :destroy]

    resources :posts, only: [:create, :destroy, :edit, :update] do
      member do
        delete :destroy_image
      end
    end

    member do
      delete :destroy_image
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "shops#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
