Rails.application.routes.draw do
  root 'home#index'
  get "home" => "courses#show"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get '/users/sign_out' => 'devise/sessions#destroy'
  get "users/show" => "users#show"
  resources :courses, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :relationships, only: [:create, :destroy]

  resources :courses do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create] 
  end
end
