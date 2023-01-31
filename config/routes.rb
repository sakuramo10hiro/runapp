Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only:[:index, :show] 
  get "user/:id" => "users#show"
  get "mypage" => "courses#index"
  get "otherpage" => "courses#all_index" 
  resources :courses, only: [:new, :create, :edit, :update, :destroy, :show, :index, :all_index]do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create,:destroy] 
    member do
      get :index_user
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
     get :followings, :followers
    end
  end
end
