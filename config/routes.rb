Rails.application.routes.draw do
  root 'home#index'
  get "home" => "courses#show"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get '/users/sign_out' => 'devise/sessions#destroy'
  resources :courses, only: [:new, :create, :edit, :update, :destroy]

  resources :courses do
    resource :favorites, only: [:create, :destroy]
 end
end
