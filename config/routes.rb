Rails.application.routes.draw do
  get 'mypages/show'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:show] do
    get :favorites, on: :member
  end

  resource :mypage, only: :show

  resources :shops, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :shop_favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "shops#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
