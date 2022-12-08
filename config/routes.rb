Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :courses, only: [:new, :create, :edit, :update, :destroy]
end
