Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, except: [:new, :create, :index]
  resources :friendships
  resources :posts, only: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :likes, only: [:create, :destroy]
  
  root 'static_pages#home'
  post "/", to: "posts#create"
end
